function WconFirst=Affinitymatrix(NumEdge,k,ConPixDouble,Sup1,Sup2,Sup3)
%% calculate the edge weight
    Dcol=zeros(NumEdge,3);
    mm=1;
    for j=1:k-1
        for z=j+1:k
            if ConPixDouble(j,z)>0
                DcolTem = sqrt( ( Sup1(j)-Sup1(z) ).^2 + ( Sup2(j)-Sup2(z) ).^2 + ( Sup3(j)- Sup3(z) ).^2 );
                Dcol(mm, 1: 3 )=[j,z,DcolTem ];
                mm=mm+1;
            end
        end
    end   
%%  the affinity matrix of the graph model
    DcolNor = normalize( Dcol(:,3) );       
    weight = exp( -10*DcolNor ) + .00001;   
    WconFirst = sparse( [Dcol(:,1);Dcol(:,2)], [Dcol(:,2);Dcol(:,1)], [weight,weight],k ,k );   %sparseœ° Ëæÿ’Û
    WconFirst = full(WconFirst )+eye(k);    %the affinity matrix of the graph model 