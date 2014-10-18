function [Pred_nb] = nb_test(model, Xtest)
Pred_nb = zeros(size(Xtest, 1), 1);
model.tmodel(:,1)
transpose(Xtest(1, :))
sum(log(model.tmodel(:,1) .^ transpose(Xtest(1, :))))
for i = 1: size(Xtest, 1)
	if( (sum(log(model.tmodel(:,1) .^ transpose(Xtest(i, :)))) + model.pY0) > (sum(log(model.tmodel(:,2) .^ transpose(Xtest(i, :))))) + model.py1)
		Pred_nb(i) = 0;
	else
		Pred_nb(i) = 1;
	end
end
end