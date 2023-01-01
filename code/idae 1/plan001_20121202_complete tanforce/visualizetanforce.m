
function matris = visualizetanforce(tanforce, nbin, skydata)
    
	matris = resizeimageto(tanforce, nbin, 4200);
    
    if(nargin == 3)% show starts
        for i = 1 : size(untitled, 1)
            %drawrectangle(mat, uint32(skydata(i,1)), uint32(skydata(i,2)), 1, 255);
            matris(uint32(skydata(i,1)), uint32(skydata(i,2))) = 1;
            matris(uint32(skydata(i,1))-1, uint32(skydata(i,2))) = 1;
            matris(uint32(skydata(i,1))+1, uint32(skydata(i,2))) = 1;
            matris(uint32(skydata(i,1)), uint32(skydata(i,2))-1) = 1;
            matris(uint32(skydata(i,1)), uint32(skydata(i,2))+1) = 1;
        end 
        imshow(scale255(matris));
    end
   
end

