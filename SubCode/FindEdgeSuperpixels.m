function   [EdgSupleft,EdgSupup,EdgSup] = FindEdgeSuperpixels( Labels, K,  height, width )
%%
% obtain the indication of edge super-pixels
% Input:
%          Labels:   the super-pixel label obtained from SLIC
%          K:        the number of super-pixels
%          height:   the height of the image
%          width:    the width of the image
%          EdgSupleft: the leftedge superpixel is indicated by value 1
%          EdgSupup:   the upedge superpixel is indicated by value 1
%          
% Output: 
%          EdgSupleft, EdgSupup, EdgSup                
%%%%====================================================================
EdgSup=zeros( K,1);
EdgSupleft=zeros( K,1);
EdgSupright=zeros( K,1);
EdgSupup=zeros( K,1);
EdgSupdown=zeros( K,1);
for i=1:height            
    EdgSupleft ( Labels( i,1 )+1 ) =1;    
    EdgSupright( Labels(i, width) +1 )=1; 
end
for i=1:width
    EdgSupup (Labels(1,i) +1 )= 1 ;     
    EdgSupdown(Labels(height,i) +1 ) =1; 
end
EdgSup=EdgSupleft+EdgSupright+EdgSupup+EdgSupdown;  




