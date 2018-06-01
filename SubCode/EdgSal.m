function   bdSal = EdgSal(B,NumEdg)
%%
%to calculate saliency via boundary%
%%
b1=4/5;
b2=4/5;
B=fliplr(sort(B,2));   
bB=sum(B(:,1:floor(b1*NumEdg)),2);
fB=sum(B(:,ceil(b2*NumEdg):NumEdg),2);
bSal=1-bB;
fSal=fB;
bdSal=exp(bSal).*(fSal);
 