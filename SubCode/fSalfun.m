  function fSal=fSal2(bSal,k,WconFirst,Edg)
  %%
  % to calculate saliency via foreground cues%
  %%
 %% binary with an adaptive threhold (i.e. mean of the saliency map)
  th=mean(bSal);
  bSal(bSal>=0.6*th)=1;
%%
  NumFor=length(find(bSal)==1);
  %% 生成一个前景R2 %%
  ForWcon=Wbdfor(bSal,k,NumFor,WconFirst);
  D1=diag(sum(WconFirst,2)+sum(ForWcon,2));
  R1=D1\ForWcon;
  %% --生成一个N--%%
  NumEdg=length(find(Edg>0));
  EdgWcon=Wbdfor(Edg,k,NumEdg,WconFirst);
  alph=1;
  D2=diag(sum(WconFirst,2)+sum(EdgWcon,2));
  Wcon = D2\WconFirst; 
  I = eye( k );
  N=(I-alph*Wcon)\I;
%% -key step--%%
  Bf=N*R1;                                          
  Bf=fliplr(sort(Bf,2));
  Bf1=sum(Bf(:,1:floor(2*NumFor/5)),2);
  Sal=Bf1;
  fSal = normalize(Sal);