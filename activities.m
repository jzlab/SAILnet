% Joel Zylberberg, UC Berkeley 2010
% joelz@berkeley.edu
% activities.m - Simulate LIF neurons to get spike counts
% function Y=activities(X,Q,W,theta)
% X:        input array
% Q:        feedforward weights
% W:        horizontal weights
% theta:    thresholds
% Y:        outputs
%*****************************************************
% for work stemming from use of this code, please cite
% Zylberberg, Murphy & DeWeese (2011) "A sparse coding model with synaptically
% local plasticity and spiking neurons can account for the diverse shapes of V1
% simple cell receptive fields", PLoS Computational Biology 7(10).
%****************************************************

function Y=activities(X,Q,W,theta)

% size of data array
[N batch_size]=size(X);
sz=sqrt(N);

% number of outputs
M=size(Q,1);

% number iterations
num_iterations=50;

% rate parameter for numerical integration
eta=0.1;

% projections of stimuli onto FF weights
B=Q*X;

% threshold
T=repmat(theta,1,batch_size);

% initialize values
Ys= zeros(M,batch_size);
as= zeros(M,batch_size);
Y = zeros(M,batch_size);

for t=1:num_iterations
	% diffeq for y
    Ys=(1-eta)*Ys + eta*(B - W*as);

	%hard threshold: spikes
	as = ones(M,batch_size);
	as(find(Ys<T)) = 0;
	
    %ad spikes to the count
    Y = Y + as;
    
	%if you spiked, start back at resting potential
	Ys(find(Ys>T)) = 0.0;
	
end

