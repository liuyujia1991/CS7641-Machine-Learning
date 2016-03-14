function [ class ] = mycluster( bow, K )
%
% Your goal of this assignment is implementing your own text clustering algo.
%
% Input:
%     bow: data set. Bag of words representation of text document as
%     described in the assignment.
%
%     K: the number of desired topics/clusters. 
%
% Output:
%     class: the assignment of each topic. The
%     assignment should be 1, 2, 3, etc. 
%
% For submission, you need to code your own implementation without using
% any existing libraries

% YOUR IMPLEMENTATION SHOULD START HERE!

[nd,nw] = size(bow);

%Initialize
Gamma = ones(nd,K)/K;
Mu_rand = rand(nw,K);
Mu = zeros(nw,K);
Sum = sum(Mu_rand);
for k=1:K
    Mu(:,k)=Mu_rand(:,k)/Sum(k);
end
Pi = ones(1,K);
Gamma_temp = zeros(nd,K);
Mu_temp = zeros(nw,K);
Pi_temp = zeros(1,K);

n=50;

while (~isequal(Gamma_temp,Gamma)||~isequal(Mu_temp,Mu)||~isequal(Pi_temp,Pi))&&(n>0)
    Gamma_temp = Gamma;
    Mu_temp = Mu;
    Pi_temp = Pi;
    n=n-1;

    %E-step
    M = ones(nd,K);
    for i = 1:nd
        for k = 1:K
            for j = 1:nw
                M(i,k) = M(i,k)*(Mu(j,k))^bow(i,j);
            end
        end
    end

    document_all = zeros(1,nd);
    for i = 1:nd
        for k = 1:K
            document_all(i) = document_all(i)+Pi(k)*M(i,k); 
        end
    end

    for i = 1:nd
        for k = 1:K
            Gamma(i,k) = Pi(k)*M(i,k)/document_all(i);
        end
    end

    %M-step
    N = zeros(nw,K);
    for k = 1:K
        for j = 1:nw
            for i = 1:nd
                N(j,k) = N(j,k)+Gamma(i,k)*bow(i,j);
            end
        end
    end

    M = zeros(1,K);
    for k = 1:K
        for l = 1:nw
            M(k) = M(k)+N(l,k);
        end
    end

    for j = 1:nw
        for k = 1:K
            Mu(j,k) = N(j,k)/M(k);
        end
    end

    Pi = zeros(1,K);
    for k = 1:K
        for i = 1:nd
            Pi(k) = Pi(k)+1/nd*Gamma(i,k);
        end
    end

end

class = ones(1,nd);
[Max, Index]=max(Gamma');
class = Index';



