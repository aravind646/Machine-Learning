function [model] = nb_train(Xtrain, Ytrain)

count1 = sum(Ytrain);
count0 = size(Ytrain,1) - count1;
pY0 =log( count0 / (count1 + count0));
py1 = log( count1 / (count1 + count0));
model.pY0 = pY0;
model.py1 = py1;
tmodel = zeros(size(Xtrain,2), 2);
dictcount0 = zeros(size(Xtrain,2), 1);
dictcount1 = zeros(size(Xtrain,2), 1);
totalY0 = 0;
totalY1 = 0;

for i = 1: size(Xtrain,1)
	for dictWords = 1: size(Xtrain,2)
		if(Ytrain(i) == 0)
			dictcount0(dictWords) = dictcount0(dictWords) + Xtrain(i, dictWords);
			totalY0 = totalY0 + Xtrain(i, dictWords);
		else
			dictcount1(dictWords) = dictcount1(dictWords) + Xtrain(i, dictWords);
			totalY1 = totalY1 + Xtrain(i, dictWords);
		end
	end
end
for dictw = 1: size(Xtrain,2)
	tmodel (dictw, 1) = (dictcount0(dictw) + 1) / (totalY0 + size(Xtrain,2));
	tmodel (dictw, 2) = (dictcount1(dictw) + 1) / (totalY1 + size(Xtrain,2));
end
model.tmodel = tmodel;		
end