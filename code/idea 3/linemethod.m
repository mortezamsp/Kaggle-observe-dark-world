%uses line method -an old method to iris detedtion- to detect
% circle-center in image, a circle could be stars around halo
%
%

function [cx cy] = linemethod(skydata, imsize)

	mat(imsize, imsize) = 0;
	for i = 1 : size(skydata, 1)
		x = skydata(i, 1);
		y = skydata(i, 2);
		e2 = skydata(i, 4);
		
		mat = draw_inf_line(mat, x, y, e2);
    end

    mat2 = mat;
    mat2(1:10, :) = 0;
    mat2(:, 1:10) = 0;
    mat2(imsize-10:imsize, :) = 0;
    mat2(:, imsize-10:imsize) = 0;
%     mat2(uint32(imsize-imsize/20):imsize, :) = 0;
%     mat2(:, uint32(imsize-imsize/20):imsize) = 0;
    mat2 = mat2 > max(max(mat2)) * 0.5;
    [px py] = find(mat2 == 1);
    
    if(size(px, 1) < 1)
        cx = 0;
        cy = 0;
        return
    end
    tan(size(px, 1)) = 0;
    dotw = 4200 / imsize;
    ofs = dotw / 2;
    for i = 1 : size(px, 1)
        x0 = px(i)*dotw + ofs;
        y0 = py(i)*dotw + ofs;
        %tan(i) = tangentialforceat(skydata, px(i), py(i));
        for k = 1 : size(skydata, 1)
            x = skydata(k, 1);
            y = skydata(k, 2);
            e1 = skydata(k, 3);
            e2 = skydata(k, 4);

            angle_wrt_halo = atan((y-y0)/(x-x0));
            tan(i) = tan(i) + -(e1*cos(2.0*angle_wrt_halo)+e2*sin(2.0*angle_wrt_halo));
        end
    end
    
    [a b] = max(tan);
    cx = px(b);
    cy = py(b);
    
    clear mat
    clear mat2
end

function newmat = draw_inf_line(mat, x, y, alpha)
	m=(alpha*pi)+pi/4;%m = 1 / alpha;
    width = size(mat, 1);
	height = size(mat, 2);
    newmat = mat;
    
    if(m<= pi/4)
        y1 = max(1,min(height, (1-x)*m+y));
        y2 = max(1,min(height, (width-x)*m+y));
        for j = min(y1, y2) : max(y1, y2)
            i = uint32(floor(max(1,min(height, ...
                (j-y)/m+x))));
            j2 = uint32(floor(max(1, j)));
            newmat(i, j2) = mat(i, j2) + 1;
        end
    else
        for i = 1 : size(mat, 1)
            j = uint32(floor(max(1,min(height, ...
                (i-x)*m+y))));
            i2 = uint32(floor(max(1,i)));
            newmat(i2, j) = mat(i2, j) + 1;
        end
    end
    
    clear mat
end
