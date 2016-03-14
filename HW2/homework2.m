function [] = homework2( )
% This is a simple example to help you evaluate your clustering algo implementation. You should run your code several time and report the best
% result. The data contains a 400*101 matrix call X, in which the last
% column is the true label of the assignment, but you are not allowed to
% use this label in your implementation, the label is provided to help you
% evaluate your algorithm. 
%
%
% Please implement your clustering algorithm in the other file, mycluster.m. Have fun coding!

load('data');
T = X(:,1:100);
label = X(:,101);
report = zeros(20,2);
for i = 1:20
    tic
    IDX = mycluster(T,4);
    toc
    time = toc;
    acc=AccMeasure(label,IDX);
    report(i,:) = [acc time];
    i =i + 1;
end
report
max(report)
min(report)
mean(report)
end