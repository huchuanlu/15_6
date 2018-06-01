function W=Wbdfor(bdfor,k,Num,WconFirst)
%%
W=zeros(k,Num);
mm=1;
for j=1:k
    if (bdfor(j)==1 || bdfor(j)==2)
        W(:,mm)=WconFirst(:,j);            
        mm=mm+1;
    end
end