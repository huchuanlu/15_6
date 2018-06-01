function Salpix=depfun(height,width, PixNum,LabelLine,propSal,w ,k)
%% saliency map via depression function
%
for i=1:k
    if propSal(i)>0.6
        propSal(i)=propSal(i);
    else
        propSal(i)=propSal(i)*propSal(i)/0.6;
    end
end
Salpix = ConvertSalSupToSalPix( height,width, PixNum,LabelLine,propSal,w );
