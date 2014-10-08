function [Pred_nb] = nb_test(input_model, Xtest)

	size_Xtest = size(Xtest, 1);

	Pred_nb = zeros(size_Xtest, 1);
	for i = 1: zeros(size_Xtest, 1);
		if((sum(log(input_model.training_model(:,1) .^ transpose(Xtest(i, :)))) + probability_of_Y0) > (sum(log(input_model.training_model(:,2) .^ transpose(Xtest(i, :))))) + input_model.probability_of_Y1)
			Pred_nb(i) = 0;
		else
			Pred_nb(i) = 1;
		end
	end

end