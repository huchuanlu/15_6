function bSal=bSalfun(Edgleft,k,NumEdgleft,WconFirst,Edgup,NumEdgup)
  %% calculate saliency via background cues
  %
  %Output:backgroundsaliency
  EdgWconleft=Wbdfor(Edgleft,k,NumEdgleft,WconFirst);
  EdgWconup=Wbdfor(Edgup,k,NumEdgup,WconFirst);
  %% absorb MP %%--
  Bleft=AbProb( WconFirst,EdgWconleft, k);
  Bup=AbProb( WconFirst,EdgWconup, k);
  %% --Saliency left||up-- %%--
  Salleft = EdgSal(Bleft,NumEdgleft);
  Salup = EdgSal(Bup,NumEdgup);
  %% --the first stage--
  bSal=0.5*(exp(Salup)+Salleft);
  bSal = normalize(bSal);  