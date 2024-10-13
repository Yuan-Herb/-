clear;

CityNum=30;
[dislist,Clist]=tsp(CityNum);  % dislist 各城市间距距阵，Clist 城市数目

Tlist=zeros(CityNum);%禁忌表(tabu list)
cl=100;%保留前cl个最好候选解
bsf=Inf; % 保存最优解
tl=50; %禁忌长度(tabu length)
l1=200;%候选解(candidate),不大于n*(n-1)/2(全部领域解个数)
S0=randperm(CityNum);
S=S0;
BSF=S0; %  保存最好路径
Si=zeros(l1,CityNum);
StopL=2000; %终止步数
p=1;
clf;
figure(1);

while (p<StopL+1)
    if l1>CityNum*(CityNum)/2
        disp('候选解个数,不大于n*(n-1)/2(全部领域解个数)！ 系统自动退出！');
        l1=(CityNum*(CityNum)/2)^.5;
        break;
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ArrS(p)=CalDist(dislist,S);   %计算路径S长度
    i=1;
    A=zeros(l1,2);   % 在本例中产生 200 * 2 的矩阵
    while i<=l1        
        M=CityNum*rand(1,2);
        M=ceil(M); % 取整
        if M(1)~=M(2) % 相同则 i 不变重新产生随机数
            m1=max(M(1),M(2));m2=min(M(1),M(2));
            A(i,1)=m1;A(i,2)=m2; % 随机得到两个小于城市数目的数值
            if i==1
                isdel=0; % isdel 为 0 时 i 才会 + +
            else
                for j=1:i-1
                    if A(i,1)==A(j,1)&&A(i,2)==A(j,2)% 本次随机得到两个小于城市数目的数值，不能与上次的相同
                        isdel=1;
                        break;
                    else
                        isdel=0;
                    end
                end
            end
            if ~isdel
                i=i+1;
            else
                i=i;
            end
        else 
            i=i;
        end
    end
    %%%%%%%%%%%%%%%%%以上循环得到了 A(l1,2) 的随机数矩阵，每行值为两个不同城市的代号
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%交换两点
    for i=1:l1
        Si(i,:)=S;
        Si(i,[A(i,1),A(i,2)])=S([A(i,2),A(i,1)]);
        CCL(i,1)=i;
        CCL(i,2)=CalDist(dislist,Si(i,:));%计算路径Si长度
        CCL(i,3)=S(A(i,1));
        CCL(i,4)=S(A(i,2));   
    end
    %%%%%%%% Si 矩阵 在 S 行向量的基础上进行了丰富
    [fs fin]=sort(CCL(:,2)); % 以第两列的值从小到大排序。注意：fs 保存的是 第二列排序后的值，fin是第一列的的值，在本例是序号
    for i=1:cl
        CL(i,:)=CCL(fin(i),:); % 相当于CL 是CCL按距离的排序值了。
    end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
   % Tlist 禁忌表
   if CL(1,2)<bsf % bsf 初始值为 inf
        bsf=CL(1,2);
        S=Si(CL(1,1),:);        
        BSF=S;
        for m=1:CityNum
            for n=1:CityNum
                if Tlist(m,n)~=0 % Tlist 初始为 30 * 30 的 0 矩阵
                    Tlist(m,n)=Tlist(m,n)-1;
                end
            end
        end
        Tlist(CL(1,3),CL(1,4))=tl;% tl=50; %禁忌长度(tabu length)
      % 记录当前最好路径的 交换位置
   else                          % 藐视准则(aspiration criterion)
        for i=1:cl         % cl=100;%保留前cl个最好候选解
            if Tlist(CL(i,3),CL(i,4))==0 
                S=Si(CL(i,1),:); % 选一个禁忌长度已经降为0的出来
                for m=1:CityNum
                    for n=1:CityNum
                        if Tlist(m,n)~=0
                            Tlist(m,n)=Tlist(m,n)-1;
                        end
                    end
                end
                Tlist(CL(i,3),CL(i,4))=tl;%禁忌长度(tabu length) 恢复
                break;
            end
        end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Arrbsf(p)=bsf;  % 保存每步的最优解
    drawTSP(Clist,BSF,bsf,p,0); % [dislist,Clist]=tsp(CityNum); % dislist 各城市间距距阵，Clist 城市数目
    p=p+1;
end
%   注意在循环中，S,BSF 的值都发生了改变 S=Si(CL(1,1),:);        BSF=S;

BestShortcut=BSF
theMinDistance=bsf

figure(2);
plot(Arrbsf,'r'); hold on;
plot(ArrS,'b');grid;  % ArrS(p)=CalDist(dislist,S); CalDist 计算路径S长度
title('搜索过程');
legend('最优解','当前解');