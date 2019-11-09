% compare data from destructive experiment at Fraser
% 29 Oct 2019

D=dir('FraserQPol_29Oct2019\*.mat');
fname={D.name}';

name={'natural snowpack','shoveled 50cm on top',...
'smoothed','stomped down','stomped down and smoothed',...
'snow removed','mesh removed','new location','shovel test',...
'tree with snow','tree without snow'}';
    
n=1;
for n=1:length(fname)
    load(['FraserQPol_29Oct2019\' fname{n}])
    r(n).name=name{n}
    r(n).HH=S1;
    r(n).VV=S2;
    r(n).HV=S3;
    r(n).VH=S4;
end

%% get one envelope to work
figure(1);clf
f=[1 3 5 6]
c='brgk'
clear h h2
for n=1:length(f)
    subplot(211)
    dm=r(f(n)).VV;
    M=median(dm,2);
    [ns,nf]=size(dm);
    d=linspace(0,4,ns);
    E=envelope(M,20,'rms');
    dm=r(f(n)).VH;
    M2=median(dm,2);
    E2=envelope(M2,20,'rms');
    figure(1); subplot(211)
    hold on; 
    %h(n)=plot(d,M,c(n),'linewidth',1); 
    h(n)=plot(d,E,c(n),'linewidth',1)
    %h(n)=plot(d,E./E2,c(n),'linewidth',1)
    subplot(212); hold on
    h2(n)=plot(d,E2,c(n),'linewidth',1)
end
subplot(211)
axis([1 4 1.1e5 1.18e5])
title('VV')
plot([2.08 2.08],[1.1e5 1.14e5],'k-.')
plot([3.90 3.90],[1.1e5 1.14e5],'k-.')
plot([2.55 2.55],[1.1e5 1.14e5],'k')
legend(h,name(f))
subplot(212)
axis([1 4 1.1e5 1.14e5])
title('VH')
plot([2.08 2.08],[1.1e5 1.14e5],'k-.')
plot([3.90 3.90],[1.1e5 1.14e5],'k-.')
plot([2.55 2.55],[1.1e5 1.14e5],'k')
legend(h2,name(f))
