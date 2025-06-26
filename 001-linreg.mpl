with(Statistics):
# ` 输入数据`
X := [1, 2, 3, 4, 5];
Y := [2.1, 3.9, 6.1, 7.9, 10.1];

# ` 拟合模型`
model := LinearFit(a*x + b, X, Y, x, summarize = true):

# ` 计算预测值`
Y_pred := [seq(eval(model, x = X[i]), i = 1 .. nops(X))];

# ` 计算平方和`
Y_mean := Mean(Y):
SST := add((Y[i] - Y_mean)^2, i = 1 .. nops(Y));
SSM := add((Y_pred[i] - Y_mean)^2, i = 1 .. nops(Y));
SSR := add((Y[i] - Y_pred[i])^2, i = 1 .. nops(Y));

# ` 计算均方`
n := nops(Y);
k := 1;
MSM := SSM/k;
MSR := SSR/(n - k - 1);

# ` 输出结果`
F_value := MSM/MSR;
p_value = SurvivalFunction(FRatio(k, n - k - 1), F_value);

# ` 计算残差`
residuals := [seq(Y[i] - eval(model, x = X[i]), i = 1 .. n)]:
# ` 残差标准差`
sigma := StandardDeviation(residuals):
# ` 计算 x 的均值、Sxx（总平方和）`
x_mean := Mean(X):
Sxx := Variance(X)*(n - 1):

# ` 定义标准误差函数（置信区间用）`
SE_CI := x -> sigma*sqrt(1/n + (x - x_mean)^2/Sxx):

# ` t 分布的临界值（95% 置信水平）`
alpha := 0.05:
t_critical := Quantile(StudentT(n - 2), 1 - alpha/2):

# ` 置信区间上下限`
CI_lower := t -> eval(model, x = t) - t_critical*SE_CI(t):
CI_upper := t -> eval(model, x = t) + t_critical*SE_CI(t):

# ` 散点图（观测值）`
p_data := ScatterPlot(X, Y, symbol = cross, symbolsize = 15, color = blue, legend = "观测值"):
# ` 回归线`
p_fit := plot(model, x = min(X) - 0.5 .. max(X) + 0.5, color = red, thickness = 1, legend = "回归线"):
# ` 置信区间（填充区域）`
CI_band := plot([CI_lower(x), CI_upper(x)], x = min(X) - 0.5 .. max(X) + 0.5, color = [green, green], linestyle = DOT, thickness = 1, legend = ["95% 置信区间", "95% 置信区间"], transparency = 0.05):
with(plots):
# ` 组合图形`
display(p_data, p_fit, CI_band, title = "一元线性回归与置信区间", labels = ["X", "Y"], axes = boxed);
