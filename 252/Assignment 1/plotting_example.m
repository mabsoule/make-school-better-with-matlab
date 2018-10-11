
%Define Variables

    delta = 0.01; % Defined delta or step size to approximate the continous function as a array of digits
                % 10ms in this case... so each value in xt and yt are 10ms
                % apart
    xt = ones(1,100); % x(t) function values incremented by delta 
    yt = 0.01:0.01:2; % y(t) function values incremented by delta 
   
%Plot original functions
    %Create time axis based on input length
    len_xt = length(xt);
    len_yt = length(yt);
    maxlen = max(len_xt,len_yt); %find longest input length
    maxVal = maxlen * delta; %find max time value (to know what to plot)
    t = 0:delta:(maxVal-delta) %create time access; start at t=0 : increase by delta : go until maxVal - delta is reached 
                               %(since we assume it's starting at t = 0 not t = delta)
    
    %Make arrays equal length for plotting;
    if len_xt > len_yt
        normalized_yt = [yt, zeros(1, len_xt - len_yt)];
        normalized_xt = xt;
    elseif len_yt > len_xt
        normalized_xt = [xt, zeros(1, len_yt - len_xt)];
        normalized_yt = yt;
    else
        normalized_xt = xt;
        normalized_yt = yt;
    end
        
        
    %Plot input functions
    subplot(211);
    plot(t, normalized_xt);
    subplot(212);
    plot(t, normalized_yt);
    
    
    