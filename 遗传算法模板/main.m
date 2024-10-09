%HNoWa%
clc;clear;
%% 基础参数
N = 100;  %种群内个体数目
N_chrom = 2; %染色体节点数，也就是每个个体有多少条染色体，其实说白了就是看适应函数里有几个自变量。
iter = 1000; %迭代次数，也就是一共有多少代
mut = 0.2;  %突变概率
acr = 0.2; %交叉概率
best = 1; %好像没用哈哈哈
chrom_range = [-10 -10;10 10];%每个节点的值的区间——自变量范围
chrom = zeros(N, N_chrom);%存放染色体的矩阵
fitness = zeros(N, 1);%存放染色体的适应度
fitness_ave = zeros(1, iter);%存放每一代的平均适应度
fitness_best = zeros(1, iter);%存放每一代的最优适应度
chrom_best = zeros(1, N_chrom+1);%存放当前代的最优染色体与适应度

%% 初始化，这只是用于生成第一代个体，并计算其适应度函数
chrom = Initialize(N, N_chrom, chrom_range); %初始化染色体
fitness = CalFitness(chrom, N, N_chrom); %计算适应度---->更改目标函数
chrom_best = FindBest(chrom, fitness, N_chrom); %寻找最优染色体---->求解最大值还是最小值，把最优解放在end位置
fitness_best(1) = chrom_best(end); %将当前最优存入矩阵当中
fitness_ave(1) = CalAveFitness(fitness); %将当前平均适应度存入矩阵当中

%% 用于生成以下其余各代，一共迭代多少步就一共有多少代
for t = 2:iter
    chrom = MutChrom(chrom, mut, N, N_chrom, chrom_range, t, iter); %变异
    chrom = AcrChrom(chrom, acr, N, N_chrom); %交叉
    fitness = CalFitness(chrom, N, N_chrom); %计算适应度
    chrom_best_temp = FindBest(chrom, fitness, N_chrom); %寻找最优染色体
    if chrom_best_temp(end)>chrom_best(end) %替换掉当前储存的最优---->按实际情况决定是大于还是小于
        chrom_best = chrom_best_temp;
    end
    %%替换掉最劣
    [chrom, fitness] = ReplaceWorse(chrom, chrom_best, fitness);
    fitness_best(t) = chrom_best(end); %将当前最优存入矩阵当中
    fitness_ave(t) = CalAveFitness(fitness); %将当前平均适应度存入矩阵当中
end

%% 作图
figure(1)
plot(1:iter, fitness_ave, 'r', 1:iter, fitness_best, 'b')
grid on
legend('平均适应度', '最优适应度')
PlotModel(chrom_best);%两个自变量时可以用这个，这个实际返回是一个三维图，传入参数是最优解

%% 输出结果
disp(['最优染色体为', num2str(chrom_best(1:end-1))])
disp(['最优适应度为', num2str(chrom_best(end))])


