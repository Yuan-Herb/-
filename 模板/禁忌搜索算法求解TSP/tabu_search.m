clear;

CityNum=30;
[dislist,Clist]=tsp(CityNum);  % dislist �����м�����Clist ������Ŀ

Tlist=zeros(CityNum);%���ɱ�(tabu list)
cl=100;%����ǰcl����ú�ѡ��
bsf=Inf; % �������Ž�
tl=50; %���ɳ���(tabu length)
l1=200;%��ѡ��(candidate),������n*(n-1)/2(ȫ����������)
S0=randperm(CityNum);
S=S0;
BSF=S0; %  �������·��
Si=zeros(l1,CityNum);
StopL=2000; %��ֹ����
p=1;
clf;
figure(1);

while (p<StopL+1)
    if l1>CityNum*(CityNum)/2
        disp('��ѡ�����,������n*(n-1)/2(ȫ����������)�� ϵͳ�Զ��˳���');
        l1=(CityNum*(CityNum)/2)^.5;
        break;
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ArrS(p)=CalDist(dislist,S);   %����·��S����
    i=1;
    A=zeros(l1,2);   % �ڱ����в��� 200 * 2 �ľ���
    while i<=l1        
        M=CityNum*rand(1,2);
        M=ceil(M); % ȡ��
        if M(1)~=M(2) % ��ͬ�� i �������²��������
            m1=max(M(1),M(2));m2=min(M(1),M(2));
            A(i,1)=m1;A(i,2)=m2; % ����õ�����С�ڳ�����Ŀ����ֵ
            if i==1
                isdel=0; % isdel Ϊ 0 ʱ i �Ż� + +
            else
                for j=1:i-1
                    if A(i,1)==A(j,1)&&A(i,2)==A(j,2)% ��������õ�����С�ڳ�����Ŀ����ֵ���������ϴε���ͬ
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
    %%%%%%%%%%%%%%%%%����ѭ���õ��� A(l1,2) �����������ÿ��ֵΪ������ͬ���еĴ���
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%��������
    for i=1:l1
        Si(i,:)=S;
        Si(i,[A(i,1),A(i,2)])=S([A(i,2),A(i,1)]);
        CCL(i,1)=i;
        CCL(i,2)=CalDist(dislist,Si(i,:));%����·��Si����
        CCL(i,3)=S(A(i,1));
        CCL(i,4)=S(A(i,2));   
    end
    %%%%%%%% Si ���� �� S �������Ļ����Ͻ����˷ḻ
    [fs fin]=sort(CCL(:,2)); % �Ե����е�ֵ��С��������ע�⣺fs ������� �ڶ���������ֵ��fin�ǵ�һ�еĵ�ֵ���ڱ��������
    for i=1:cl
        CL(i,:)=CCL(fin(i),:); % �൱��CL ��CCL�����������ֵ�ˡ�
    end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
   % Tlist ���ɱ�
   if CL(1,2)<bsf % bsf ��ʼֵΪ inf
        bsf=CL(1,2);
        S=Si(CL(1,1),:);        
        BSF=S;
        for m=1:CityNum
            for n=1:CityNum
                if Tlist(m,n)~=0 % Tlist ��ʼΪ 30 * 30 �� 0 ����
                    Tlist(m,n)=Tlist(m,n)-1;
                end
            end
        end
        Tlist(CL(1,3),CL(1,4))=tl;% tl=50; %���ɳ���(tabu length)
      % ��¼��ǰ���·���� ����λ��
   else                          % ����׼��(aspiration criterion)
        for i=1:cl         % cl=100;%����ǰcl����ú�ѡ��
            if Tlist(CL(i,3),CL(i,4))==0 
                S=Si(CL(i,1),:); % ѡһ�����ɳ����Ѿ���Ϊ0�ĳ���
                for m=1:CityNum
                    for n=1:CityNum
                        if Tlist(m,n)~=0
                            Tlist(m,n)=Tlist(m,n)-1;
                        end
                    end
                end
                Tlist(CL(i,3),CL(i,4))=tl;%���ɳ���(tabu length) �ָ�
                break;
            end
        end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Arrbsf(p)=bsf;  % ����ÿ�������Ž�
    drawTSP(Clist,BSF,bsf,p,0); % [dislist,Clist]=tsp(CityNum); % dislist �����м�����Clist ������Ŀ
    p=p+1;
end
%   ע����ѭ���У�S,BSF ��ֵ�������˸ı� S=Si(CL(1,1),:);        BSF=S;

BestShortcut=BSF
theMinDistance=bsf

figure(2);
plot(Arrbsf,'r'); hold on;
plot(ArrS,'b');grid;  % ArrS(p)=CalDist(dislist,S); CalDist ����·��S����
title('��������');
legend('���Ž�','��ǰ��');