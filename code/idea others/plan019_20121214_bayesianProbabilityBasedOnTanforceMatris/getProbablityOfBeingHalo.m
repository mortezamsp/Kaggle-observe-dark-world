function probe = getProbablityOfBeingHalo(tanmat, hx, hy)

    tanmat = scale255(tanmat);
    
	probe(256) = 0;
	s = size(tanmat, 1);
	rhx = uint32(max(1,floor(hx*s/4200)));
	rhy = uint32(max(1,floor(hy*s/4200)));
	probe(floor(tanmat(rhx, rhy))) = 1;
	
	for k = 1 : 4
		for i = max(1, rhx-k) : min(s, rhx+k)
            if(rhy-k > 0)
                v = floor(tanmat(i, rhy-k));
                probe(v + 1) = probe(v + 1) + (4-k+1) * 0.25;
            end
            if(rhy+k <= s)
                v = floor(tanmat(i, rhy+k));
                probe(v + 1) = probe(v + 1) + (4-k+1) * 0.25;
            end
		end
		for i = max(1, rhy-k) : min(s, rhx+k)
            if(rhx-k > 0)
                v = floor(tanmat(rhx-k, i));
                probe(v + 1) = probe(v + 1) + (4-k+1) * 0.25;
            end
            if(rhx+k <= s)
                v = floor(tanmat(rhx+k, i));
                probe(v + 1) = probe(v + 1) + (4-k+1) * 0.25;
            end
		end
	end
	
end
