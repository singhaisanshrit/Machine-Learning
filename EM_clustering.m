function [ class ] = mycluster( bow, K )
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
Itr = 50;
nd = length(bow(:,1));
nw = length(bow(1,:));
mu = ones(nw,K)/100; %Mean Initialization
T = bow';
gamma = zeros(400,4); %Responsibility
w = [0.27 ,0.23,0.258,0.242]; %Weights

for itr = 1:Itr
for i = 1:nd
    gamma(i,:) = w.*(prod(mu(:,:).^T(:,i)));
end
b = sum(gamma');
gamma = gamma./b';  
for i = 1:nw
    mu(i,:) = sum(gamma(:,:).*bow(:,i));
    
end
c = sum(mu);
mu = mu./c;
w = sum(gamma)/100;
end
for i = 1:nd
[~,idx(i)] = max(gamma(i,:));
end
class = idx; %Indexing
end
