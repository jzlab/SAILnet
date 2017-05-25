% initialize SAILnet parameters
% Joel Zylberberg, UC Berkeley 2010
% joelz@berkeley.edu
%*****************************************************
% for work stemming from use of this code, please cite
% Zylberberg, Murphy & DeWeese (2011) "A sparse coding model with synaptically
% local plasticity and spiking neurons can account for the diverse shapes of V1
% simple cell receptive fields", PLoS Computational Biology 7(10).
%****************************************************

fprintf('Here we go _/) \n');

clear all

% the whitened image array
load IMAGES

%general params
batch_size =100;        
num_trials = 25000;

%input data
[imsize imsize num_images]=size(IMAGES);
BUFF=20;

% number of inputs
N=256;      %number of pixels in the patches
sz = sqrt(N);

% number of outputs
OC = 1;		%overcompleteness of neurons wrt pixels
M=OC*N;

% target output firing rate; spikes per neuron per image
p=0.05;

% Initialize network parameters 
%feedforward weights Q
%horizontal connections W
%thresholds theta

Q=randn(M,N);
Q=diag(1./sqrt(sum(Q.*Q,2)))*Q;
W=zeros(M);
theta=2*ones(M,1);

% learning rates
alpha=1;
beta=0.01;
gamma=0.1;

% rate parameter for computing moving averages to get activity stats
eta_ave=0.3;

% initialize average activity stats
Y_ave=p;
Cyy_ave=p^2;