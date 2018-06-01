
%%
addpath( './SubCode/' );
Salmap = './Saliencymap/';         
mkdir( Salmap );            
imgpath = './Input/';         
ImgEnum=dir([imgpath '*.png']);  
ImgNum=length(ImgEnum);
for i= 1 :ImgNum
    i
    imname = [ imgpath ImgEnum(i).name ]; 
    %% to remove the frame of the image %%
    [Img,w]=removeframe(imname);
    Img=Img*255;
    [ height,width ] = size(Img(:,:,1));
    PixNum = height*width;    
    %% consider the input image is the gray case %%
    [a,b,c]=size(Img);
    if c~=3                     
      ImgVecR = reshape( Img, PixNum, 1);
      ImgVecG=ImgVecR;
      ImgVecB=ImgVecR;       
    else     
    ImgVecR = reshape( Img(:,:,1)', PixNum, 1);
    ImgVecG = reshape( Img(:,:,2)', PixNum, 1);
    ImgVecB = reshape( Img(:,:,3)', PixNum, 1);
    end   
    if c~=3
        Im=im2double(imread(imname));
    else
        Im=im2double(rgb2gray(imread(imname)));
    end
%% m is the compactness parameter, k is the super-pixel number in SLIC algorithm
    m = 20;k = 250;  
    ImgAttr=[ height ,width, k, m, PixNum ];
    [ LabelLine, Sup1, Sup2, Sup3, k ] = SLIC( ImgVecR, ImgVecG, ImgVecB, ImgAttr );   
    Label=reshape(LabelLine,width,height);    
    Label = Label';                                   
    feat = zeros(k,3);
    feat(:,1)=Sup1;
    feat(:,2)=Sup2;
    feat(:,3)=Sup3;
%% count the number of the edge in the graph
  [ ConPix, ConPixDouble ] = find_connect_superpixel( Label, k, height ,width );
  NumEdge = NumEd( ConPixDouble, k);
%%  the affinity matrix of the graph model
  WconFirst=Affinitymatrix(NumEdge,k,ConPixDouble,Sup1,Sup2,Sup3);
%% find_edge_Superpixels
  [Edgleft,Edgup,Edg] = FindEdgeSuperpixels( Label, k,  height, width );
  NumEdgleft=length(find(Edgleft==1));
  NumEdgup=length(find(Edgup==1));
%% --the first stage--
  bSal=bSalfun(Edgleft,k,NumEdgleft,WconFirst,Edgup,NumEdgup);
%% --the second stage--%%
  fSal=fSalfun(bSal,k,WconFirst,Edg);
%% Context-based error propagation 
  propSal = descendPropagation(feat,fSal,k,3);
%% depress function %%
  Salpix=depfun(height,width, PixNum,LabelLine,propSal,w ,k);
%% -guidedfilter-%%
  Sal=guidedfilter(Im, Salpix, 5, 0.1);
  imwrite( Sal, [ Salmap, ImgEnum(i).name(1:end-4), '.png' ] );
end