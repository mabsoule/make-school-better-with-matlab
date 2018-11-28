clear
w = 2;
t = 0:0.01:10;

%test 1: x(t) = sin(wt)
k1 = [-1, 0, 1];
aks1 = [1/2*j, 0, -1/2*j]
ctfs(aks1, k1, w, t)


% test 2: x(t) = 1 + sin(wt) + 2cos(wt) + cos(2wt + pi/4)
k2 = [-2, -1, 0, 1, 2];
aks2 = [sqrt(2)*(1-1j)/4, 1+(0.5j), 1, 1-(0.5j), sqrt(2)*(1+1j)/4];
%ctfs(aks2, k2, w, t)

%test 3: x(t) = cos(wt)
k3 = [-1, 0, 1]
aks3 = [1/2, 0, 1/2]
%ctfs(aks3, k3, w, t)

% inputs: k array and corresponding ak array (must be the same length), w,
% t (time vector)
% outputs: plot of x(t)
function synthesis = ctfs(aks, k, w, time)
    n = numel(k);
    graph = 0;
    for x = 1:n
        graph = graph + aks(x)*exp(1j*k(x)*w*time)  
    end
    plot(time, real(graph))
end




        