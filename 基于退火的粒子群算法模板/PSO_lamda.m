function [xm,fv] = PSO_lamda(fitness,N,c1,c2,lamda,M,D)
format long;
%N为初始化群体个体数目
%c1为学习因子1
%才为学习因子2
%lamda为退火常数惯性权重
%M为最大迭代次数
%D为搜索空间维数
%%%%%%%%%%初始化种群的个体%%%%%%%%%%%
for i=1:N
    for j=1:D
        %x(i,j)=randn;%初始化位置
        x(i,j) = -10 + 20 * rand(); % 生成在 -10 到 10 之间的随机数
        v(i,j)=randn;%初始化速度
    end
end
%%%%%%%%%%%计算各个粒子的适应度，并初始化pi和pg%%%%%%%%%%%
for i=1:N
    p(i)=fitness(x(i,:));
    y(i,:)=x(i,:);
end
pg=x(N,:);
for i=1:(N-1)
    if fitness(x(i,:))<fitness(pg)
        pg=x(i,:);
    end
end
%%%%%%主循环，按照公式依次迭代%%%%%%%%%%%
T=-fitness(pg)/log(0.2);
for t=1:M
    groupFit=fitness(pg);
    for i=1:N
        Tfit(i)=exp(-(p(i)-groupFit)/T);
    end
    SumTfit=sum(Tfit);
    Tfit=Tfit/SumTfit;
    pBet=rand();
    for i=1:N
        ComFit(i)=sum(Tfit(1:i));
        if pBet<=ComFit(i)
            pg_plus=x(i,:);
            break;
        end
    end
    C=c1+c2;
    ksi=2/abs(2-C-sqrt(C^2-4*C));
    for i=1:N
        v(i,:)=ksi*(v(i,:)+c1*rand*(y(i,:)-x(i,:))+c2*rand*(pg_plus-x(i,:)));
        x(i,:)=x(i,:)+v(i,:);
        if fitness(x(i,:))<p(i)
            p(i)=fitness(x(i,:));
            y(i,:)=x(i,:);
        end
        if p(i)<fitness(pg)
            pg=y(i,:);
        end
    end
    T=T*lamda;
    Pbest(t)=fitness(pg);
end
xm=pg';
fv=fitness(pg);




