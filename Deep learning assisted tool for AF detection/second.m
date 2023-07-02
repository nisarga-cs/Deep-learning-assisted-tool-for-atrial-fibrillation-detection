for j=1:8528
    try
    disp(strcat('=====',num2str(j),'======'));
    strx=strcat('sss',num2str(j)); 
    load(strcat(strx, '.mat'));
if segment==0;
    j=j+1;
    continue; 
end
N=size(segment);
   disp(N(1));
   for u=1:200
       ls=0;
       for v=1:N(1)
           ls(v)=segment(v,u);
       end
       
       M(j,u)=median(ls);
      %value.data=M;
      
   end
   segment=0;
    catch
     continue
end
 end
 %Saving the median
 str2='C:/ECG Classification/MEDIAN.mat';
 save(str2,'M');
 xlswrite('Median.xlsx',MEDIAN)