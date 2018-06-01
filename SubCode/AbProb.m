 function  B = AbProb( WconFirst,EdgWcon, k)
 %%
 %calculate the absorbing probablity matrix%
 %%
alph=1;
D=diag(sum(WconFirst,2)+sum(EdgWcon,2));
Q =  D \ WconFirst; 
R=D \ EdgWcon;
I = eye( k );
N=(I-alph*Q)\I;
B=N*R;