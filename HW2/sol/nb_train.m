function [model] = nb_train(Xtrain, Ytrain)
	% Get the number of elements of both the classes
	number_of_elements_of1 = sum(Ytrain);
	number_of_elements_of0 = Ytrain - number_of_elements_of1;

	% Get the probability of both the classes
	probability_of_Y0 =log( number_of_elements_of0 / (number_of_elements_of1 + number_of_elements_of0));
	probability_of_Y1 = log( number_of_elements_of1 / (number_of_elements_of1+number_of_elements_of0));

	% storing it in the model
	model.probability_of_Y0 = probability_of_Y0;
	model.probability_of_Y1 = probability_of_Y1;

	size_of_Xtrain_2 = size(Xtrain,2);
	training_model = zeros(size_of_Xtrain_2, 2);

	dict_count_0 = zeros(size_of_Xtrain_2, 1);
	dict_count_1 = zeros(size_of_Xtrain_2, 1);

	total_count_Y0 = 0;
	total_count_Y1 = 0;

	for i = 1: size(Xtrain,1)
		for dictionary_words = 1: size_of_Xtrain_2
			% According to class, place it in the appropirate variable
			if (Ytrain(i) == 0)
				dict_count_0(dictionary_words) = dict_count_0(dictionary_words) + Xtrain(i, dictionary_words);
				total_count_Y0 = total_count_Y0 + Xtrain(i, dictionary_words);
			else
				dict_count_1(dictionary_words) = dict_count_1(dictionary_words) + Xtrain(i, dictionary_words);
				total_count_Y1 = total_count_Y1 + Xtrain(i, dictionary_words);
			end
		end
	end

	% Putting it in the model
	for current_word = 1: size_of_Xtrain_2
		training_model (current_word, 1) = (training_model (current_word, 1) + 1) / (total_count_Y0 + size_of_Xtrain_2);
		training_model (current_word, 2) = (training_model (current_word, 2) + 1) / (total_count_Y1 + size_of_Xtrain_2);
	end

	% storing it in the model
	model.training_model = training_model;		
end