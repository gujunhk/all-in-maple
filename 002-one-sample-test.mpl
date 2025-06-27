with(Statistics):

# 输入数据
data := [261, 484, 171, 380, 178, 265, 221, 158, 281, 100, 213, 223, 363, 167, 251, 148];
mu0 := 230;  # 假设的总体均值
alpha :=0.05; # 显著水平
# 执行t检验
result := OneSampleTTest(data, mu0, confidence=1-alpha, alternative='uppertail', summarize=true);

# 输出结果
# printf("Test Results:\n");
# pvalue := rhs(select(x -> lhs(x) = `pvalue`, {result})[1]);
# printf("p-value: %f\n", pvalue);
# printf("Confidence Interval: %a\n", rhs(select(x -> lhs(x) = `confidenceinterval`, {result})[1]));
# printf("t-value: %f\n", rhs(select(x -> lhs(x) = `statistic`, {result})[1]));
# printf("p-value > alpha: %s\n", evalb(pvalue > alpha));
