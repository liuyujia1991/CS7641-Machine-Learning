function [ U, V ] = myRecommender( rateMatrix, lowRank )
    % Please type your name here:
    name = 'Liu, Yujia';
    disp(name); % Do not delete this line.

    % Parameters
    maxIter = 0; % Choose your own.
    learningRate = 0.0005; % Choose your own.
    regularizer = 1; % Choose your own.
    
    % Random initialization:
    [n1, n2] = size(rateMatrix);
    U = rand(n1, lowRank) / lowRank;
    V = rand(n2, lowRank) / lowRank;
    residual = 10;
    % Gradient Descent:
    
    while ( (residual > 0.8) && (maxIter < 300) )
        
        R = (rateMatrix - U*V') .* (rateMatrix ~= 0);

        U = U - 2*learningRate*regularizer*U + 2*learningRate*R*V;
        V = V - 2*learningRate*regularizer*V + 2*learningRate*R'*U;

        residual = norm((U*V' - rateMatrix) .* (rateMatrix > 0), 'fro') / sqrt(nnz(rateMatrix > 0));
        maxIter = maxIter + 1;
    end
end