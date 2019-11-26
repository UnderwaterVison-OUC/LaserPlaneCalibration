% Auto-generated by cameraCalibrator app on 20-Nov-2019
%-------------------------------------------------------


% Define images to process
imageFileNames = {'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-15.bmp',...
    'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-16.bmp',...
    'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-17.bmp',...
    'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-18.bmp',...
    'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-19.bmp',...
    'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-20.bmp',...
    'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-21.bmp',...
    'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-22.bmp',...
    'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-23.bmp',...
    'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-24.bmp',...
    'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-25.bmp',...
    'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-26.bmp',...
    'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-27.bmp',...
    'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-28.bmp',...
    'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-29.bmp',...
    'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-32.bmp',...
    'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-36.bmp',...
    'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-37.bmp',...
    'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-38.bmp',...
    'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-39.bmp',...
    'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-40.bmp',...
    'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-41.bmp',...
    'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-42.bmp',...
    'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-43.bmp',...
    'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-44.bmp',...
    'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-45.bmp',...
    'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-46.bmp',...
    'F:\OneDrive - stu.ouc.edu.cn\3CodeList\1激光三角法\测试数据\test2\calibration\w-48.bmp',...
    };
% Detect checkerboards in images
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames);
imageFileNames = imageFileNames(imagesUsed);

% Read the first image to obtain image size
originalImage = imread(imageFileNames{1});
[mrows, ncols, ~] = size(originalImage);

% Generate world coordinates of the corners of the squares
squareSize = 30;  % in units of 'millimeters'
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Calibrate the camera
[cameraParams, imagesUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', false, 'EstimateTangentialDistortion', false, ...
    'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'millimeters', ...
    'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', [], ...
    'ImageSize', [mrows, ncols]);

% View reprojection errors
h1=figure; showReprojectionErrors(cameraParams);

% Visualize pattern locations
h2=figure; showExtrinsics(cameraParams, 'CameraCentric');

% Display parameter estimation errors
displayErrors(estimationErrors, cameraParams);

% For example, you can use the calibration data to remove effects of lens distortion.
undistortedImage = undistortImage(originalImage, cameraParams);

% See additional examples of how to use the calibration data.  At the prompt type:
% showdemo('MeasuringPlanarObjectsExample')
% showdemo('StructureFromMotionExample')

save cameraParams cameraParams
for i=1:5
originalImage = imread(imageFileNames{i});
undistortedImage = undistortImage(originalImage, cameraParams);
imshow(undistortedImage); title(i);
pause;
end
% See additional examples of how to use the calibration data.  At the prompt type:
% showdemo('MeasuringPlanarObjectsExample')
% showdemo('StructureFromMotionExample')
