clear;

CityNum=10;
[dislist,Clist]=tsp(CityNum);

A=500;
B=500;
C=200;
D=500;
arf=1;
miu0=0.02;
lan=0.00001;
EndNum=1000;
  % Hopfield 法，本处参数含义见 《现代优化计算方法》第二版P199
  %循环神经网络---->可能落入局部最优
y=zeros(CityNum,CityNum);
for i=1:CityNum
    y(i,i)=1;
end
z=-miu0/2*log(9)*ones(CityNum,CityNum);
delu=0.1*miu0*rand(CityNum,CityNum); % 扰动的均匀分布

figure(1);
for k=1:EndNum
    z=z+lan*delu;
    for u=1:CityNum
        for i=1:CityNum
            y(u,i)=1/(1+exp(-2*z(u,i)/miu0));% Sigmoid 函数
        end
    end
    for u=1:CityNum
        for i=1:CityNum
            A1=0;
            B1=0;
            for aa=1:CityNum
                A1=A1+y(u,aa);
                B1=B1+y(aa,i);
            end
            A1=A1-y(u,i); 
            B1=B1-y(u,i);
            C1=0;
            for aa=1:CityNum
                for bb=1:CityNum
                    C1=C1+y(aa,bb);
                end
            end
            C1=C1-CityNum;
            D1=0;
            for x=1:CityNum
                if x~=u
                    if i==1                    
                        D1=D1+dislist(u,x)*(y(x,2)+y(x,CityNum));     % 此处上下语句均为 计算 书 p 198页 第 6.5.12 式
                    elseif i==CityNum
                        D1=D1+dislist(u,x)*(y(x,1)+y(x,CityNum-1));
                    else
                        D1=D1+dislist(u,x)*(y(x,i+1)+y(x,i-1));
                    end
                end
            end
            delu(u,i)=-z(u,i)*arf-A*A1-B*B1-C*C1-D*D1;  % 由能量函数得出的求解关系式
        end
    end          % 并在前式中， z=z+lan*delu; y 由 Z 修正，即 y=f(z).
    
    for i=1:CityNum
        [x n]=max(y(:,i));   % 最优路径由此产生
        S(i)=n;
    end
    % 判别有无重复点
    for i=1:CityNum-1
        for j=i+1:CityNum
            if S(i)~=S(j)
                ff=1;
            else
                ff=0;
                break;
            end
            if ff==0
                break;
            end
        end
        if ff==0
            break;
        end
    end

    if ff==1
        bsf=CalDist(dislist,S);
    else
        bsf=4;
    end
  % 路径无重复点，则赋值并绘图
    Arrbsf(k)=bsf;
    drawTSP10(Clist,S,bsf,k,0);
    %pause;
end
figure(2);
plot(Arrbsf,'r'); hold on;
title('搜索过程');
legend('最优解');