cclc;clear all;close all;
k=1;
%file numbers excluded
A=[49;54;59;103;129;137;158;164;217;245;378;445;473;483;488;504;549;669;714;923;1169;2579;3014;3054;3778;3981;4522;5007;5984;6351;6484;6485;6634;7818;8029;8509];
b =[-15.21394065;-15.28709455	-15.28088337	-15.48412698	-15.30572809	-15.31677019	-15.15769496	-14.92236025	-14.67356798	-14.09730849	-13.43098689	-12.67598344	-11.94064872	-11.33195307	-10.67943409	-10.23706004	-10.01276743	-9.824361629	-9.893719807	-10.10835059	-10.42097999	-11.02518979	-11.53312629	-11.97377502	-12.40752243	-12.65562457	-12.87508627	-12.79365079	-12.65355418	-12.35093168	-12.03278123	-11.71773637	-11.1452726	-10.26604555	-9.271221532	-8.394755003	-7.524154589	-6.681504486	-5.727743271	-4.523464458	-3.417529331	-2.291925466	-1.158730159	0.107660455	1.678743961	2.951345756	4.288129745	5.596963423	7.200483092	8.606625259	9.999654934	11.11973775	12.0610766	12.7905452	13.1884058	13.40200138	13.19013112	12.75845411	12.13595583	11.2084196	10.18702553	8.918564527	7.433747412	5.744996549	3.932712215	1.916839199	-0.009661836	-1.944099379	-3.92615597	-6.018978606	-7.918219462	-9.614216701	-11.03450656	-12.44064872	-13.58626639	-14.87750173	-15.95859213	-16.99792961	-17.91028295	-18.51276743	-18.82850242	-19.11111111	-19.60835059	-20.33540373	-21.29744651	-22.67563837	-24.09592823	-24.69530711	-22.78847481	-17.01897861	-3.802967564	22.09765355	66.16804693	131.8799172	218.531746	320.7487923	428.5866115	523.9530711	581.0238095	575.9306418	515.4358178	390.1984127	224.1466529	57.69185645	-77.43754313	-155.426156	-174.4620428	-156.5269151	-123.5462388	-90.89544513	-69.19496204	-57.42063492	-51.92270531	-49.97412008	-49.08523119	-48.28812974	-47.69599724	-46.7815735	-45.77846791	-44.62353347	-43.50448585	-42.32229124	-41.20048309	-39.67598344	-38.02726018	-36.09489303	-34.18875086	-32.18357488	-30.65320911	-29.36300897	-27.90027605	-26.21773637	-24.51311249	-22.80883368	-20.67115252	-18.50552105	-16.23153899	-14.28951001	-12.53485162	-10.38854382	-8.366114562	-6.192891649	-4.04899931	-1.805383023	0.698412698	3.49378882	5.929606625	8.709109731	11.51414769	14.38647343	17.58592133	20.88750863	24.18909593	27.43961353	31.03933747	34.52311939	38.04520359	42.06625259	46.12594893	49.542098	52.72325742	55.84679089	58.49758454	61.2826087	63.46066253	65.87957212	67.92477571	69.65804003	71.34195997	72.13871636	72.80917874	73.00552105	72.47584541	71.82643202	70.894755	69.65838509	68.29537612	66.36404417	63.93029676	61.22429262	58.46376812	55.30020704	51.19806763	47.06452726	42.73464458	38.16287095	33.29641132	28.46963423	23.77777778	19.46859903	15.6031746	12.05037957	8.545203589	5.437198068	2.270531401	-0.548654244	-3.056935818	-5.50310559	-7.697032436	-9.763285024

%input file loading starts here
 for j=1:1
        if k>18
          k=1;
      end
      if(j==A(k))
        segment=0;
        str5='C:\ECG Classification\';
        str10=strcat('sss', num2str(j) ,'.mat');
        stry=strcat(str5,str10);
        save(stry,'segment');
        j=j+1;
        k=k+1;
        continue;
      end    
 end
for j=1:
    try
        pause;
     disp(strcat('=====',num2str(j),'======'));
     str1='A0';
       if j<10
              strx= strcat(str1, '000', num2str(j));
       end
       if (j>=10 && j<100)
              strx= strcat(str1, '00', num2str(j));
       end
       if (j>=100 && j<1000)
              strx= strcat(str1, '0', num2str(j));
       end
       if (j>=1000)
              strx= strcat(str1, num2str(j));
       end
         
  load(strcat(strx, '.mat'));

subplot(211);
plot(val(1,:));

%QRS detection starts here
close all; clear INDEX; clear MID; clear I;clear x1; clear x2; clear x3; clear x4; clear x5;

[C,L]=wavedec(val(1,:),8,'db6');
        C(1:L(1))=zeros(1,L(1));
        x=waverec(C,L,'db6');
        x1(1)=x(1);
        for i=2:length(x)
            x1(i)=x(i)-x(i-1);
        end
        x1=abs(x1);
        x2(1)=x1(1);
        x2(2)=x1(1);
        for i=3:length(x1)
            x2(i)=(x(i)+2*x(i-1)+x(i-2))/2;
        end
        x3(1)=x2(1);
        for i=2:length(x2)
            x3(i)=x2(i)-x2(i-1);
        end
        x3=abs(x3);
        x4(1)=x3(1);
        x4(2)=x3(1);
        for i=3:length(x3)
            x4(i)=(x3(i)+2*x3(i-1)+x3(i-2))/2;
        end
       thresh=0.35*max(x4);
        for i=1:length(x4)
            if x4(i)>=thresh
                x5(i)=1;
            else x5(i)=0;
            end
        end
        ini=[];fin=[];
        for i=2:length(x5)
            if x5(i-1)==0 && x5(i)==1
                ini=[ini i];
            elseif x5(i-1)==1 && x5(i)==0
                fin=[fin i-1];
            end
        end
        if (length(ini)~=length(fin))
            if (ini(length(ini))>fin(length(fin)))
                ini=ini(1:length(ini)-1);
            end
        end
        if fin(1)<ini(1)
            fin=fin(2:length(fin));
        end
        if ini(length(ini))>fin(length(fin))
            ini=ini(1:(length(ini)-1));
        end
        
        MID=floor((ini+fin)/2);
        
%       MID=MID-3;
        for i=1:length(MID)
            if MID(i)<4
        [junk, I(i)]=max(x(1:(MID(i)+3)));
            elseif (MID(i)+3)>length(x)
                [junk, I(i)]=max(x((MID(i)-3):length(x)));
            else
                [junk, I(i)]=max(x((MID(i)-3):(MID(i)+3)));
            end
        end
        INDEX=MID-4+I;
        
        data1=[];
           if INDEX(length(INDEX))<length(x)+30
               INDEX=INDEX(1:length(INDEX)-1);
           end
           
        ind_count=[];
        for i=2:length(INDEX)
            if ((INDEX(i)-INDEX(i-1))<40)
               ind_count=[ind_count i];
            end
        end
        
        INDEX(ind_count)=[];
           figure(1)
           plot(x)
           hold on;
           plot(INDEX, x(INDEX), 'r*');
        for i=1:length(INDEX)-1
            if (INDEX(i)+100)> length(x)
                INDEX=INDEX(1:length(INDEX)-1);
            elseif (INDEX(i)-100)<0
                INDEX=INDEX(2:length(INDEX)); 
            end
        end
            for i= 1:length(INDEX)
                if (INDEX(i)+100)>length(x)
                    break;
                end
                 if (INDEX(i)-99)<1
                    break;
                end
            data1=[data1; x((INDEX(i)-99):(INDEX(i)+100))'];
           end
        
        data.data=data1;

% =================================================================
%Segmentation of 200 samples symmetric to QRS(99,0,100)  
%n is number of QRS complex in the loaded signal
    n=length(INDEX);
    display(n);
    if n==0  
        segment=0;
        str5='C:\ECG Classification\';
        str10=strcat('sss', num2str(j) ,'.mat');
        stry=strcat(str5,str10);
        save(stry,'segment');
        j=j+1;
        continue;
    end
    if n==1
        if(INDEX<100)  
            segment=0;
            str5='C:\ECG Classification\';
            str10=strcat('sss', num2str(j) ,'.mat');
            stry=strcat(str5,str10);
            save(stry,'segment');
            j=j+1;
            continue;
        end
        if ((INDEX+100)>length(val))
            segment=0;
            str5='C:\ECG Classification\';
            str10=strcat('sss', num2str(j) ,'.mat');
            stry=strcat(str5,str10);
            save(stry,'segment');
            j=j+1;
            continue;
        end
%         segment(i,1:200)=val((INDEX(i)-99):(INDEX(i)+100));
%         segments.data=segment; 
    end
  
    for i=1:n
        if(INDEX(i)<100) 
            i=i+1;
            continue;
        end
        if (i==n && (INDEX(i)+100)>length(val)) 
            i=i+1;
            continue;
        end
        segment(i,1:200)=val((INDEX(i)-99):(INDEX(i)+100));
        segments.data=segment;
         
%       str2=strcat('segmentss', num2str(j) ,'.mat');
%       savefile=(str2);
%       save(str2,'segment');   
    end
    str5='C:\ECG Classification\';
    str10=strcat('sss', num2str(j) ,'.mat');
    stry=strcat(str5,str10);
    save(stry,'segment');
    plot(sss)
    segment=0;
    
    catch
        continue
end   
end

    