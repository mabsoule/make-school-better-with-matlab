%Define Variables

    clear %Prevent past inputs altering convolution
    
    %Enter Sampling Step Size 
    delta = 0.01; % Defined delta or step size to approximate the continous function as a array of digits
                  % 10ms in this case... so each value in xt and yt are 10ms apart
    
    %Enter signal 1 data
        %Sample inputs; only uncomment one at a time so you don't mess up
        %the xt length
        xt = ones(1,100); % x(t) function values incremented by delta
        %xt = 0.01:0.01:2;
        %xt = [1 1 1 0 0 0]
    
    x_lowerbound = 0; %enter where xt starts with respects to time
    x_upperbound = x_lowerbound + (length(xt)*delta);
    
    
    %Enter signal 2 data
        %Sample inputs; only uncomment one at a time so you don't mess up
        %the xt length
        yt = 0.01:0.01:2; % y(t) function values incremented by delta
        %yt = [0.5 0.2 0.3]
        %yt = ones(1,100);

    
    y_lowerbound = 0; %enter where xt starts with respects to time
    y_upperbound = y_lowerbound + (length(yt)*delta);
    
%Compute the convolution of z(t) = x(t) * y(t):

    %Find bounds of t that give the full picture of the convolution result
        %First lets define all the values of t we need to plug into our
        %approximation to get a full picture of z(t) (this will control our
        %outer for loop!)

        %Let's fix x(t) in all cases... This means we need to shift and flip
        %y(t) so that it aligns with one element overlap with x(t) to give up
        %our first non-zero sumation value

        %Let's flip the bounds 
        y_flipped_lower = (-1) * y_lowerbound;
        y_flipped_upper = (-1) * y_upperbound;

        %Now we need to find t such that y_flipped_lower + t = x_lowerbound...
        %to find the smallest value of t that results in overlap

        t_low = x_lowerbound - y_flipped_lower;

        %Now we need to find t such that y_flipped_upper + t = x_upperbound...
        %to find the largest value of t that results in overlap 

        t_high = x_upperbound - y_flipped_upper;

        %Let's create an array to store all the t values we will plug into our
        %summation approximation - Note this is the x-axis range of t that we
        %will plot for z(t) and has all the non-zero convolution sums

        t_convolution = t_low:delta:t_high;

    %Compute approximation sum for each t_convolution value
    
    %each convolution sum results in all values of x multiplied by some
    %flipped and shifted version of y(t)... we can flip them since that's
    %true for all... then for each convolution step we can shift y(t)
    %(replacing unfilled spots with 0's), cut it off on the values that overlap xt and sum the multiplications of
    %each corralating indecies in each array
    
    %We know the bounds of z(t) now...the first value is the with one
    %overlap the rest zeros then 2 with the rest zeros ... and so on until
    %the values disappear off the other side so lets assign y(t) values to the
    %xt size array so we can multiply pairs & sum it
    
    %Compute convolution
    for i = 1:length(t_convolution)
    %Find the array that represents the values of yt that overlap x(t)
       
        %Add length(xt) zero's to the end of array for regions that do not
        %overlap on both sides of yt (this gives us all values of yt that
        %will be convoluted with the stationary x(t).
            
            %Add to end of y(-t)
            yt_convolution = [yt, zeros(1,length(xt))];

            %Reverse yt
            yt_convolution = flip(yt_convolution);

            %Add to front of y(-t)
            yt_convolution = [yt_convolution, zeros(1,length(xt))];
        
        %Now we have a reversed y(t) that is shifted over to the position
        %where the non-zero values of y(t) just do not overlap with x(t). 
        %Now lets shift the signal right by i so we align the convolution
        %with the proper time value already recorded in t_convolution
        
            %shift right
            for j = 1:i %Minimum shift is 1 since we added length(x(t)) 
                        %zero's. We must shift ones to get our first overlap term
                yt_convolution = shift_array_right(yt_convolution);
            end
        
        %Our yt_convolution is now shifted into position but is still to
        %big! We must now make it the same size as x(t). Note we want the
        %values counted from the right of the array as these are the ones
        %that overlap x(t) when it's fliped and shifted.
            
            %Get length of array we need
            arraySize = length(xt);
            
            %Flip array to get last values
            yt_convolution = flip(yt_convolution);
           
            %Transfer desired data to a new final array
            for k = 1:arraySize
                yt_resizedAndBeautiful(k) = yt_convolution(k);
            end
            
            %Flip array to put back into correct order
            yt_resizedAndBeautiful = flip(yt_resizedAndBeautiful);
            
            
        %Sum each multiplied pair of values at each time value 
        zt(i)= sum(xt.*yt_resizedAndBeautiful);
    end
    
  
%Final plot
    figure
    plot(t_convolution,zt);
    xlabel('time (s)')
    ylabel('z(t) (AU)')
    title('Convolution of z(t) = x(t) * y(t)')
    %xticks(0:0.2:3);
    
% Plotting to compare with matlab conv function
%     figure
%     subplot(211)
%     plot(t_convolution,zt)
%     xlabel('time (s)')
%     ylabel('z(t) (AU)')
%     title('Using Our Algorithm: Convolution of z(t) = x(t) * y(t)')
%     subplot(212)
    %Find convolution using matlabs function
%         zt = conv(xt,yt);
%     %Make a time axis the same length as the matlab result
%         for i = 1:(length(t_convolution)-2)
%             time(i) = t_convolution(i);
%         end
%     %Plot matlab function below our result
%     plot(time,zt)
%     xlabel('time (s)')
%     ylabel('z(t) (AU)')
%     title('Using Matlab Function: Convolution of z(t) = x(t) * y(t)')
%     
    
%Shifts array right one index deleting the last element & fills left side with zero
 function yt_convolution = shift_array_right(yt_convolution)
    
        %Delete last element
        yt_convolution(end) = [];
        %Flip array
        yt_convolution = flip(yt_convolution);
        %Add zero to array
        yt_convolution = [yt_convolution, zeros(1)];
        %Flip back
        yt_convolution = flip(yt_convolution);
 end

