function   Salpix = ConvertSalSupToSalPix( height,width, PixNum,LabelLine,Salsup,w)
%% to convey the saliency value from superpixel to pixel
%
%Output: the matrix form of the saliency map
Salpixtem=zeros(height,width);
SalLine = sup2pixel( PixNum, LabelLine, Salsup );
Salpix = reshape( SalLine, width, height );
Salpixtem = Salpix';
%% to recover the size of the img %%
Salpix=zeros(w(1),w(2));
Salpix(w(3):w(4),w(5):w(6))=Salpixtem;