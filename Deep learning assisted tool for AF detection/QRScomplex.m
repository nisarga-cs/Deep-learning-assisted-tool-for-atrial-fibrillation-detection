clc;clear all;close all;

%file numbers excluded

%input file loading starts here 
for j=150
    
    
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

[C,L]=wavedec(val(1,:),8,'db6');
 C(1:L(1))=zeros(1,L(1));
 
C((L(1)+L(2)+L(3)+L(4)+L(5)+L(6)+L(7)+L(8)+1):(L(1)+L(2)+L(3)+L(4)+L(5)+L(6)+L(7)+L(8)+L(9)))=zeros(1,L(9));
 
x=waverec(C,L,'db6');

fs=300;
duration= length(val)/fs;
time=0:(1/fs):duration-(1/fs);
plot(time,val); 
xlabel('time in seconds-->');
ylabel('Amplitude of raw_ecg');

[qrs_amp_raw,qrs_amp_ind,delay]=pan_tompkin(x,fs,1); 

%third argument 1 to vusualize ECG waveforms
%xlim([0 2000])
qrs_amp_ind_sec = (1/fs).*qrs_amp_ind; %QRS interval in seconds
pause;
end