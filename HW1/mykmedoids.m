function [ class, centroid ] = mykmedoids( pixels, K )
%
% Your goal of this assignment is implementing your own K-medoids.
% Please refer to the instructions carefully, and we encourage you to
% consult with other resources about this algorithm on the web.
%
% Input:
%     pixels: data set. Each row contains one data point. For image
%     dataset, it contains 3 columns, each column corresponding to Red,
%     Green, and Blue component.
%
%     K: the number of desired clusters. Too high value of K may result in
%     empty cluster error. Then, you need to reduce it.
%
% Output:
%     class: the class assignment of each data point in pixels. The
%     assignment should be 1, 2, 3, etc. For K = 5, for example, each cell
%     of class should be either 1, 2, 3, 4, or 5. The output should be a
%     column vector with size(pixels, 1) elements.
%
%     centroid: the location of K centroids in your result. With images,
%     each centroid corresponds to the representative color of each
%     cluster. The output should be a matrix with size(pixels, 1) rows and
%     3 columns. The range of values should be [0, 255].
%     
%
% You may run the following line, then you can see what should be done.
% For submission, you need to code your own implementation without using
% the kmeans matlab function directly. That is, you need to comment it out.

%	[class, centroid] = kmeans(pixels, K);

%Initialization
centroid = zeros(K,3);
num = size(pixels,1);
class = ones(num,1);
distance = zeros(K,1);
temp = zeros(num,1);

%Initialize the centroid
for i=1:K
    centroid(i,:) = randi(255,1,3);
end

while temp~= class
    temp = class;
%Assign pixels to the cluster
    for N=1:num
        for i=1:K
            distance(i) = (centroid(i,1)-pixels(N,1))^2+(centroid(i,2)-pixels(N,2))^2+(centroid(i,3)-pixels(N,3))^2;
        end
        [m,n] = min(distance);
        class(N) = n;
    end

%Update the centroid 
    for i=1:K
        pixelsk=[];
        numk=0;
        for N=1:num
            if class(N)==i
            pixelsk=[pixelsk;pixels(N,1:3)];
            numk=numk+1;
            end
        end
        sorted=sort(pixelsk);
        if mod(numk,2)==1
            centroid(i,1:3) = sorted((numk+1)/2,1:3);
        else
            if numk~=0
                centroid(i,1:3) = sorted(numk/2,1:3);
            else
                centroid(i,1:3) = [0,0,0];
            end    
        end
    end
end
end
