
load prob.mat
load Training_Sky_tanforces_bin400
load TrainingHalos

probsky{100} = 0;
for i = 2 : 100
	mat = trainingskytanforce.matris{i};
    a = mat;
    
	for m = 1 : 400
		for n = 1 : 400
			mat(m, n) = prob(max(1,floor( mat(m, n) )));
		end
    end
	
    probsky{i} = mat;
    
    %probedge = scale255(a) - 255 * edge(mat, 'sobel');
%     probeim = scale255(a) - uint8(255 * (a > max(max(a)) * 0.99));
%     probeim = drawzoom(probeim,...
%         TrainingHalos(i, 4)*400/4200, TrainingHalos(i,5)*400/4200,...
%         10, 255, 0, 0) ;
    imwrite(probeim, ['probeim_train_' num2str(i) '.jpg'], 'jpg');
    imwrite(mat, ['probeim_train_' num2str(i) '_2.jpg'], 'jpg');
end

save probsky.mat probsky
