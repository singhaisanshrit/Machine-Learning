function [prob] = algorithm(q)
data = load('sp500')
dat = data.price_move
A = [0.8, 0.2 ; 0.2, 0.8]; % Transition Probability 
B = [q, 1-q ; 1-q, q]; % Emission
  if dat (1) == 1;
    B1 = B(1,1);
    B2 = B(1,2);
  else dat(1) == -1;
      B1 = B(2,1) ; 
      B2 = B(2,2);
  end
%pi(1) for good and pi(2) for bad
pi(1) = 0.2; pi (2) = 1- pi(1); %Initial Probability.
% Implementing forward Algorithm
alpha1(1) = pi(1) * B1 ;
alpha2(1) = pi(2) * B2 ;
palpha_S(1) = alpha1(1) + alpha2(1);
alpha = zeros(size(dat,1), 2);
alpha(1,:) = [alpha1(1) , alpha2(1)];
for i = 2: size(dat,1)
     if dat (i) == 1;
         B1 = B(1,1);
         B2 = B(1,2);
     else dat(i) == -1;
         B1 = B(2,1); 
         B2 = B(2,2);
     end
  alpha1(i) = B1*(A(1,1)* alpha(i-1,1)) + B1*(A(2,1)*alpha(i-1,2)) ;
  alpha2(i) = B2*(A(1,2)* alpha(i-1,1)) + B2* (A(2,2)*alpha(i-1,2)) ;
  alpha(i,:)= [alpha1(i), alpha2(i)];
end
%Implementing Backward algorithm
beta = zeros(size(dat,1), 2);
% Initializing
beta1(39) = 1 ;
beta2(39) = 1 ;
beta(39,:) = [beta1(39) , beta2(39)];
for i = size(dat,1)-1:-1:1
     if dat (i+1) == 1;
         B1 = B(1,1);
         B2 = B(1,2);
     else dat(i+2) == -1;
         B1 = B(2,1); 
         B2 = B(2,2);
     end
  beta1(i) = B1*(A(1,1)* beta(i+1,1)) + B2*(A(1,2)*beta(i+1,2)) ;
  beta2(i) = B1*(A(2,1)* beta(i+1,1)) + B2*(A(2,2)*beta(i+1,2)) ; 
  beta(i,:)= [beta1(i) , beta2(i)];
end
for i = 1:2
prod(:,i) = alpha(:,i).*beta(:,i);
end
P = prod'; Q = sum(P);
for i = 1:2 % Calculating Probability
prob(:,i)= prod(:,i)./Q';
end
disp(' probability that the economy is in a good state in the week of week 39 is');
disp(prob(39,1));
plot(linspace(1,size(dat,1),size(dat,1)),prob(:,1));
xlabel('Week') 
ylabel('P(Economy in good state)')
legend('good')
end