% show_network.m - display network parameters


function show_network(theta,Y_ave,W,Cyy_ave,Q)

figure(1)

M=size(Q,1);

subplot(221)
imagesc(W), colorbar, axis image
title('W')

subplot(222)
C=Cyy_ave-Y_ave*Y_ave';
imagesc(C,[0 max(C(:))]), colorbar, axis image
title('Cyy\_ave')

subplot(223)
showrfs(Q)
title('Q')

subplot(224)
bar(theta)
title('theta')

drawnow
