%I want to calculate the diameter of a dark object on a light background
%along the horizontal direction
img = imread('object.jpg'); %acquiring an RGB image of the object
imgGray = rgb2gray(img); %converting into grayscale
levelThreshold = graythresh(imgGray); %calculating automatically
                                      %a binarization threshold
imgBw = im2bw(imgGray, levelThreshold); %binarizing the image
diameter = 0; %declaring variables
rightBound = 0;
leftBound = 0;
for i = 1:1000 %loop for each image row (suppose a 1000x1000 image)
    for j = 1:1000 %for each row, loop for each cell (image's pixel)
        if imgBw(i, j) == 0 %if the cell is black
            rightBound = j; %memorize the cell position as the right extreme.
                            %This value will be updated from time to time,
                            %until all cells in the row have been inspected.
                            %In this way, the final value stored for the right
                            %extreme will be the position of the pixel where,
                            %in the line, the object ends
            if leftBound == 0 %if no position for the left extreme has been
                              %memorized yet, I memorize the cell position
                              %as the left extreme. In this way, I memorize
                              %the point where, in the line I am inspecting,
                              %I found for the first time a black pixel.
                              %That is the point where the object starts
                leftBound = j;
            end
        end
    end
    if rightBound == 0 && leftBound == 0 %if the line is completely white
        rowDiameter = 0; %the object has no size in that line
    else 
        rowDiameter = rightBound - leftBound + 1; %otherwise, I calculate
                                                  %the size of the object in
                                                  %that line (I consider +1
                                                  %because otherwise the size
                                                  %would not count a pixel)
    end
    if rowDiameter >= diameter %if the object’s size along the line is greater
                               %than or equal to the last value stored for the
                               %object diameter
        diameter = rowDiameter; %I update the value of the object’s diameter.
                                %In this way, I saved in the variable “diameter”
                                %the value of the maximum size of the object
                                %found along the lines
        row = i; %memorize the line where I updated the diameter value for
                 %the last time, so at the end I know in which line of the
                 %image is the maximum size of the object (the diameter)
    end
    rightBound = 0; %reinitialize the variables for the next step
    leftBound = 0;
end
disp(sprintf('the diameter is %d px\nin the row %d of the image', diameter, row));
