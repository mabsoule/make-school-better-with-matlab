% Given k, w, amplitude we can find T (period) and tv (time vector)
%inputs: x(t)(put into function xt below), k, w, dx (increment)
%output: corresponding ak value for inputted k
clear
k = 1;
w = 1;
dx = 0.0001;

ctfs(k, w, dx)

function xt = signal(t, w)
    %xt = sin(w*t);
    xt = 1 + sin(w*t) + 2*cos(w*t) + cos(2*w*t+(pi/4)); 
end

function analysis = ctfs(k, w, dx)
    T = 2*pi/w;
    tv = 0:dx:T;
    n = numel(tv);
    summation = zeros(1,n);
    
    for i = 1:n
        mid = tv(i) + dx/2;
        xt = signal(mid, w);
        op = xt*dx*exp(-1j*k*w*mid);
        summation(i) = op;
    end
    finalsum = sum(summation)/T;
    finalsumreal = real(finalsum);
    finalsumimag = imag(finalsum);
    output = ['For k = ', num2str(k), ', the ak value is: ', num2str(finalsumreal), ' + j(', num2str(finalsumimag), ')'];
    disp(output)
end
    
    