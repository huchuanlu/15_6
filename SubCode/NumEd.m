function   NumEdge = NumEd( ConPixDouble, k)
%% count the number of the edge in the graph
NumEdge=0;
    for j=1:k-1
        for z=j+1:k
            if ConPixDouble(j,z)>0            
                NumEdge=NumEdge+1;
            end
        end
    end         