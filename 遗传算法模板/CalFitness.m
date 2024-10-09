%适应度计算
function fitness = CalFitness(chrom, N, N_chrom)
fitness = zeros(N, 1);
%开始计算适应度
for i = 1:N
    x = chrom(i, 1);
    y = chrom(i, 2);
    fitness(i) = sin(x)+cos(y)+0.1*x+0.1*y;%%该函数是定义的适应度函数，也可称为代价函数，用于以后筛选个体的评价指标
end

end

