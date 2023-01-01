

load TrainingHalos
load Training_Sky_tanforces_bin400

prob(256) = 0;
for i = 2 : 100
	prob = prob + getProbablityOfBeingHalo(...
		trainingskytanforce.matris{i},...
        TrainingHalos(i, 4), TrainingHalos(i, 5));
end

prob = prob / 100;

save prob.mat prob
