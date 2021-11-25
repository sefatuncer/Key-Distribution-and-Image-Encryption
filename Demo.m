clear all
close all
clc

s = 5558; % secret number
k = 3;
n = 6;
d = ShamirSharing(s,k,n);
c = d(1:4,:);
r = ShamirReconstruction(c,k);

display(['the secret info is ' num2str(s)])
display('the used info is:')
display(c);
display(['reconstruction is ' num2str(r)])