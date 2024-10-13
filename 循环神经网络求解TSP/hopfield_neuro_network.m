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
  % Hopfield ����������������� ���ִ��Ż����㷽�����ڶ���P199
  %ѭ��������---->��������ֲ�����
y=zeros(CityNum,CityNum);
for i=1:CityNum
    y(i,i)=1;
end
z=-miu0/2*log(9)*ones(CityNum,CityNum);
delu=0.1*miu0*rand(CityNum,CityNum); % �Ŷ��ľ��ȷֲ�

figure(1);
for k=1:EndNum
    z=z+lan*delu;
    for u=1:CityNum
        for i=1:CityNum
            y(u,i)=1/(1+exp(-2*z(u,i)/miu0));% Sigmoid ����
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
                        D1=D1+dislist(u,x)*(y(x,2)+y(x,CityNum));     % �˴���������Ϊ ���� �� p 198ҳ �� 6.5.12 ʽ
                    elseif i==CityNum
                        D1=D1+dislist(u,x)*(y(x,1)+y(x,CityNum-1));
                    else
                        D1=D1+dislist(u,x)*(y(x,i+1)+y(x,i-1));
                    end
                end
            end
            delu(u,i)=-z(u,i)*arf-A*A1-B*B1-C*C1-D*D1;  % �����������ó�������ϵʽ
        end
    end          % ����ǰʽ�У� z=z+lan*delu; y �� Z �������� y=f(z).
    
    for i=1:CityNum
        [x n]=max(y(:,i));   % ����·���ɴ˲���
        S(i)=n;
    end
    % �б������ظ���
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
  % ·�����ظ��㣬��ֵ����ͼ
    Arrbsf(k)=bsf;
    drawTSP10(Clist,S,bsf,k,0);
    %pause;
end
figure(2);
plot(Arrbsf,'r'); hold on;
title('��������');
legend('���Ž�');