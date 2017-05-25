% SAILnet: Sparse And Independent Local network _/)
% Joel Zylberberg
% UC Berkeley Redwood Center for Theoretical Neuroscience
% joelz@berkeley.edu
% Dec 2010
%*****************************************************
% for work stemming from use of this code, please cite
% Zylberberg, Murphy & DeWeese (2011) "A sparse coding model with synaptically
% local plasticity and spiking neurons can account for the diverse shapes of V1
% simple cell receptive fields", PLoS Computational Biology 7(10).
%****************************************************

for t = 1:num_trials

	% extract subimages at random from IMAGES array to make data array X
	for i=1:batch_size
		r=BUFF+ceil((imsize-sz-2*BUFF)*rand);
		c=BUFF+ceil((imsize-sz-2*BUFF)*rand);
		myimage=reshape(IMAGES(r:r+sz-1,c:c+sz-1,ceil(num_images*rand)),N,1);
		myimage = myimage-mean(myimage);
		myimage = myimage/std(myimage);
		X(:,i) = myimage;
    end
    
    % compute network outputs for this data array
    Y = activities(X,Q,W,theta); %gives the spike counts 
    
	% compute statistics for this batch
    muy=mean(Y,2);          %average neuron activities
    Cyy=Y*Y'/batch_size;	%activity correlation between neurons
    
  % update lateral weights with Foldiak's rule: inhibition to maintain decorrelation
   dW = alpha*(Cyy - p^2); 
   W= W + dW; 
   W=W-diag(diag(W));       % zero out diagonal
   W(find(W<0))=0;          % require lateral connections to inhibit
	
	% update feedforward weights with Oja's rule
	square_act = sum((Y.*Y)');
	mymat = diag(square_act);
	dQ =  beta*Y*X'/batch_size - beta*mymat*Q/batch_size; 
	Q=Q + dQ;

	% update thresholds with Foldiak's rule: keep each neuron firing near target
	dtheta =  gamma*(sum(Y')'/batch_size - p); 
	theta=theta + dtheta; 
    
    % compute moving averages of muy and Cyy
    Y_ave=(1-eta_ave)*Y_ave + eta_ave*muy;
    Cyy_ave=(1-eta_ave)*Cyy_ave + eta_ave*Cyy;
    
    % display network state and activity statistics every so often
	if mod(t,50)==0,																	
        figure(1)
        clf
		show_network(theta,Y_ave,W,Cyy_ave,Q);
        figure(2)
        showrfs(Q)
		t		
       
    if mod(t,50000) ==0,
        save current_net
    end    
    end
end

save final_network
