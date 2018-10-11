
%TEST FOR CONCATENATING ZEROS ON BOTH SIDES
yt = [1,2,3,4]
xt = [0,0,0,0,0,0,0]

%Add to end of y(-t)
        yt_conv = [yt, zeros(1,length(xt))];
        
        %Reverse yt
        yt_conv = flip(yt_conv);
        
        %Add to front of y(-t)
        yt_conv = [yt_conv, zeros(1,length(xt))];
        
        yt_conv;
        
%TEST FOR SHIFTING AN ARRAY RIGHT AND FILLING WITH ZEROS
yt_convolution = [1,2,3,4]

for i = 1:1
    yt_convolution = shift_array_right(yt_convolution);
end

%Delete last element
yt_convolution(end) = [];
%Flip array
yt_convolution = flip(yt_convolution);
%Add zero to array
yt_convolution = [yt_convolution, zeros(1)];
%Flip back
yt_convolution = flip(yt_convolution);


       

 function yt_convolution = shift_array_right(yt_convolution)
    
        %Delete last element
        yt_convolution(end) = [];
        %Flip array
        yt_convolution = flip(yt_convolution);
        %Add zero to array
        yt_convolution = [yt_convolution, zeros(1)];
        %Flip back
        yt_convolution = flip(yt_convolution)
    end



        
        
  