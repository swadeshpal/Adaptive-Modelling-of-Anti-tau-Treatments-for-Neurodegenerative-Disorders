import matplotlib.pyplot as plt
import torch
import torch.autograd as autograd  # computation graph
from torch import nn
import pandas as pd
import numpy as np
import time

from collections import OrderedDict
from scipy.integrate import odeint
from torch.func import functional_call, grad, vmap

data = pd.DataFrame(dict(
    year=np.array([]),
    u=np.array([]),
    v=np.array([]),
    w=np.array([])))

t_train = data.year
u_train = data.u
v_train = data.v
w_train = data.w

t_train = torch.Tensor(t_train).reshape(-1, 1)
u_train = torch.Tensor(u_train).reshape(-1, 1)
v_train = torch.Tensor(v_train).reshape(-1, 1)
w_train = torch.Tensor(w_train).reshape(-1, 1)

# print(u_train.shape)

# configuration
layers = np.array([1, 10, 10, 3])  # 3 hidden layers

num_iter = 500000
interval_iter = 1000
tolerance = 1e-8
learning_rate = 1e-3


def rhs(X, t, theta):
    # unpack parameters
    x, y, z = X
    ru, bu, rv, bv, su, hu, au, rw, bw, cu, cv, xt0, yt0, zt0 = theta
    # equations
    dx_dt = ru * x - bu * x * x
    dy_dt = rv * y - bv * y * y + su * x * y / (hu * x + au)
    dz_dt = rw * z - bw * z * z + cu * x * z + cv * y * z
    return [dx_dt, dy_dt, dz_dt]


# note theta =  ru, bu, rv, bv, su, hu, au, rw, bw, cu, cv, xt0, yt0, zt0
theta = np.array(
    [0.0181, 0.000001, 0.0022, 0.00045, 0.95, 47.65, 4.397, 0.00001224, 0.03, 0.00070047, 0.0143, 472.06, 45.39, 24.22])
time_np = np.arange(55.6, 92.25, 0.01)

time = torch.Tensor(time_np).reshape(-1, 1)

# print(time.size())

# call Scipy's odeint function
uvw = odeint(func=rhs, y0=theta[-3:], t=time_np, args=(theta,))


def plot(t_pts=None, u_prediction=None, i=None):
    # plt.figure(figsize=(12, 4))
    plt.clf()
    if u_prediction is not None and i is not None:
        plt.plot(t_pts, u_prediction, label="PINN solution at iter {}".format(i), color="green")
        plt.legend()
    plt.scatter(t_train, u_train, s=2, color="blue")
    plt.ylim([0, 1800])


figure, (ax1, ax2, ax3) = plt.subplots(3, figsize=(10, 6))


def plot_u(t_pts=None, u_prediction=None, i=None):
    # plt.figure(figsize=(12, 4))
    ax1.cla()
    if u_prediction is not None and i is not None:
        ax1.plot(t_pts, u_prediction[:, 0], label="PINN solution at iter {}".format(i), color="green")
        ax1.legend()
    ax1.scatter(t_train, u_train, s=2, color="blue")
    ax1.set_ylim([0, 1800])

    ax2.cla()
    if u_prediction is not None and i is not None:
        ax2.plot(t_pts, u_prediction[:, 1], label="PINN solution at iter {}".format(i), color="green")
        ax2.legend()
    ax2.scatter(t_train, v_train, s=2, color="blue")
    ax2.set_ylim([0, 100])

    ax3.cla()
    if u_prediction is not None and i is not None:
        ax3.plot(t_pts, u_prediction[:, 2], label="PINN solution at iter {}".format(i), color="green")
        ax3.legend()
    ax3.scatter(t_train, w_train, s=2, color="blue")
    ax3.set_ylim([0, 100])


#  Deep Neural Network
class DNN(nn.Module):
    def __init__(self, layers):
        super().__init__()  # call __init__ from parent class
        'activation function'
        self.activation = nn.Tanh()
        'Initialize neural network as a list using nn.Modulelist'
        self.linears = nn.ModuleList([nn.Linear(layers[i], layers[i + 1]) for i in range(len(layers) - 1)])
        'Xavier Normal Initialization'
        for i in range(len(layers) - 1):
            nn.init.xavier_normal_(self.linears[i].weight.data, gain=1.0)
            # set biases to zero
            nn.init.zeros_(self.linears[i].bias.data)

    'foward pass'

    def forward(self, t):
        # convert to float
        a = t.float()
        for i in range(len(layers) - 2):
            z = self.linears[i](a)
            a = self.activation(z)

        a = self.linears[-1](a)
        return a


class FCN():
    def __init__(self, layers):
        self.loss_function = nn.MSELoss()

        'Initialize our new parameters'
        # note theta =  ru, bu, rv, bv, su, hu, au, rw, bw, cu, cv, xt0, yt0, zt0
        self.ru = torch.tensor([theta[0]], requires_grad=True).float()
        self.bu = torch.tensor([theta[1]], requires_grad=True).float()
        self.rv = torch.tensor([theta[2]], requires_grad=True).float()
        self.bv = torch.tensor([theta[3]], requires_grad=True).float()
        self.su = torch.tensor([theta[4]], requires_grad=True).float()
        self.hu = torch.tensor([theta[5]], requires_grad=True).float()
        self.au = torch.tensor([theta[6]], requires_grad=True).float()
        self.rw = torch.tensor([theta[7]], requires_grad=True).float()
        self.bw = torch.tensor([theta[8]], requires_grad=True).float()
        self.cu = torch.tensor([theta[9]], requires_grad=True).float()
        self.cv = torch.tensor([theta[10]], requires_grad=True).float()
        self.xt0 = torch.tensor([theta[11]], requires_grad=True).float()
        self.yt0 = torch.tensor([theta[12]], requires_grad=True).float()
        self.zt0 = torch.tensor([theta[13]], requires_grad=True).float()

        'Register the parameters to optimize'
        self.ru = nn.Parameter(self.ru)
        self.bu = nn.Parameter(self.bu)
        self.rv = nn.Parameter(self.rv)
        self.bv = nn.Parameter(self.bv)
        self.su = nn.Parameter(self.su)
        self.hu = nn.Parameter(self.hu)
        self.au = nn.Parameter(self.au)
        self.rw = nn.Parameter(self.rw)
        self.bw = nn.Parameter(self.bw)
        self.cu = nn.Parameter(self.cu)
        self.cv = nn.Parameter(self.cv)
        self.xt0 = nn.Parameter(self.xt0)
        self.yt0 = nn.Parameter(self.yt0)
        self.zt0 = nn.Parameter(self.zt0)

        'Call our DNN'
        self.dnn = DNN(layers)

        'Register our new parameter'
        self.dnn.register_parameter('ru', self.ru)
        self.dnn.register_parameter('bu', self.bu)
        self.dnn.register_parameter('rv', self.rv)
        self.dnn.register_parameter('bv', self.bv)
        self.dnn.register_parameter('su', self.su)
        self.dnn.register_parameter('hu', self.hu)
        self.dnn.register_parameter('au', self.au)
        self.dnn.register_parameter('rw', self.rw)
        self.dnn.register_parameter('bw', self.bw)
        self.dnn.register_parameter('cu', self.cu)
        self.dnn.register_parameter('cv', self.cv)
        self.dnn.register_parameter('xt0', self.xt0)
        self.dnn.register_parameter('yt0', self.yt0)
        self.dnn.register_parameter('zt0', self.zt0)

    'loss function'

    def loss_data(self, t, u, v, w):
        loss_u = self.loss_function(self.dnn(t)[:, 0].reshape(-1, 1), u)
        loss_v = self.loss_function(self.dnn(t)[:, 1].reshape(-1, 1), v)
        loss_w = self.loss_function(self.dnn(t)[:, 2].reshape(-1, 1), w)
        return loss_u + loss_v + loss_w

    def loss_PDE(self, tp):
        t_ru = self.ru
        t_bu = self.bu
        t_rv = self.rv
        t_bv = self.bv
        t_su = self.su
        t_hu = self.hu
        t_au = self.au
        t_rw = self.rw
        t_bw = self.bw
        t_cu = self.cu
        t_cv = self.cv
        t_xt0 = self.xt0.reshape(-1, 1)
        t_yt0 = self.yt0.reshape(-1, 1)
        t_zt0 = self.zt0.reshape(-1, 1)

        T = tp.clone()
        T.requires_grad = True

        u = self.dnn(T)[:, 0].reshape(-1, 1)
        v = self.dnn(T)[:, 1].reshape(-1, 1)
        w = self.dnn(T)[:, 2].reshape(-1, 1)
        u_hat = torch.zeros(T.shape[0]).reshape(-1, 1)
        v_hat = torch.zeros(T.shape[0]).reshape(-1, 1)
        w_hat = torch.zeros(T.shape[0]).reshape(-1, 1)

        u_t = autograd.grad(u, T, torch.ones(T.shape[0]).reshape(-1, 1), retain_graph=True, create_graph=True)[0]
        v_t = autograd.grad(v, T, torch.ones(T.shape[0]).reshape(-1, 1), retain_graph=True, create_graph=True)[0]
        w_t = autograd.grad(w, T, torch.ones(T.shape[0]).reshape(-1, 1), retain_graph=True, create_graph=True)[0]

        f1 = u_t - (t_ru * u - t_bu * u * u)
        f2 = v_t - (t_rv * v - t_bv * v * v + t_su * u * v / (t_hu * u + t_au))
        f3 = w_t - (t_rw * w - t_bw * w * w + t_cu * u * w + t_cv * v * w)

        l_iu = u[0, 0].reshape(-1, 1)
        l_iv = v[0, 0].reshape(-1, 1)
        l_iw = w[0, 0].reshape(-1, 1)

        loss_f = (self.loss_function(f1, u_hat) + self.loss_function(f2, v_hat) + self.loss_function(f3, w_hat) +
                  self.loss_function(l_iu, t_xt0) + self.loss_function(l_iv, t_yt0) + self.loss_function(l_iw, t_zt0))

        return loss_f

    def loss(self, t, u, v, w, tp):
        loss_uv = self.loss_data(t, u, v, w)
        loss_f = self.loss_PDE(tp)

        loss_val = loss_uv + loss_f
        return loss_val


PINN = FCN(layers)
params = list(PINN.dnn.parameters())
optimizer = torch.optim.Adam(params, lr=learning_rate)

iteration = []
loss_value = []
df_theta = []
for epoch in range(num_iter + 1):
    loss = PINN.loss(t_train, u_train, v_train, w_train, time)
    optimizer.zero_grad()
    loss.backward()
    optimizer.step()

    with torch.no_grad():
        iteration.append(epoch)
        loss_value.append(loss)
        PINN.ru[:] = PINN.ru.clamp(1e-10, 1.0)
        PINN.bu[:] = PINN.bu.clamp(1e-10, 1.0)
        PINN.rv[:] = PINN.rv.clamp(1e-10, 1.0)
        PINN.bv[:] = PINN.bv.clamp(1e-10, 1.0)
        PINN.su[:] = PINN.su.clamp(1e-10, 1.0)
        PINN.hu[:] = PINN.hu.clamp(1e-10, 200.0)
        PINN.au[:] = PINN.au.clamp(1e-10, 500.0)
        PINN.rw[:] = PINN.rw.clamp(1e-10, 1.0)
        PINN.bw[:] = PINN.bw.clamp(1e-10, 1.0)
        PINN.cu[:] = PINN.cu.clamp(1e-10, 1.0)
        PINN.cv[:] = PINN.cv.clamp(1e-10, 1.0)
        PINN.xt0[:] = PINN.xt0.clamp(100, 1600.0)
        PINN.yt0[:] = PINN.yt0.clamp(10, 100.0)
        PINN.zt0[:] = PINN.zt0.clamp(10, 100.0)

    with torch.inference_mode():
        i_step = epoch
        i_loss = loss.tolist()
        t_theta = [i_step, i_loss, PINN.ru.item(), PINN.bu.item(), PINN.rv.item(), PINN.bv.item(), PINN.su.item(),
                   PINN.hu.item(), PINN.au.item(), PINN.rw.item(), PINN.bw.item(), PINN.cu.item(), PINN.cv.item(),
                   PINN.xt0.item(), PINN.yt0.item(), PINN.zt0.item()]
        df_theta.append(t_theta)

    if epoch % interval_iter == 0:
        print('Iteration: %d | Error : %.5f | Parameter_Est_PINN = ' % (epoch, loss))
        with torch.inference_mode():
            t_theta = [PINN.ru.item(), PINN.bu.item(), PINN.rv.item(), PINN.bv.item(), PINN.su.item(),
                       PINN.hu.item(), PINN.au.item(), PINN.rw.item(), PINN.bw.item(), PINN.cu.item(), PINN.cv.item(),
                       PINN.xt0.item(), PINN.yt0.item(), PINN.zt0.item()]
            print(t_theta)
            uvw = odeint(func=rhs, y0=t_theta[-3:], t=time_np, args=(t_theta,))
            plot_u(t_pts=time, u_prediction=uvw, i=epoch)
            # u_prediction = PINN.dnn.forward(time)[:, 0].reshape(-1, 1)
            # plot(t_pts=time, u_prediction=u_prediction, i=epoch)
            #    plt.plot(time, u_prediction, color="green")
            #    print(f"U_0 = {u_prediction[0]}")
            #    plot(t_p, u_prediction=u_prediction, i=epoch)
            #     plt.show()
            plt.pause(0.0001)

theta_df = pd.DataFrame(df_theta)

theta_df.to_csv('PINN_AD_out_theta.txt', sep='\t', encoding='utf-8', index=False, header=True)
