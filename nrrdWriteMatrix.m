function nrrdWriteMatrix(matrixData, refImage, fileName)

% A wrapper around nrrdwrite to create an image from the matrixData
% and the reference image and write it out to a file named fileName.

disp('nrrdWriteMatrix:');
disp('refImage.metaData:');
disp(refImage.metaData);

imgSize = size(matrixData);

% create the output image
imgOut.metaData = {};
imgOut.metaDataFieldNames = {};

disp('matrixData =');
disp(matrixData);
% change any NaNs in the matrix to 0.0
matrixData(isnan(matrixData)) = 0.0;
disp('matrix Data post NaN conversion:');
disp(matrixData)

if isfloat(matrixData)
  imgOut.metaData.type = 'float';
 elseif isinteger(matrixData)
  imgOut.metaData.type = 'int';
else
  imgOut.metaData.type = 'uchar';
end

% assumes 3D
imgOut.metaData.dimension = '3';
imgOut.metaData.space = refImage.metaData.space;
imgOut.metaData.sizes = imgSize;
imgOut.metaData.space_directions = refImage.metaData.space_directions;
imgOut.metaData.kinds = refImage.metaData.kinds;
imgOut.metaData.endian = refImage.metaData.endian;
imgOut.metaData.encoding = refImage.metaData.encoding;
imgOut.metaData.space_origin = refImage.metaData.space_origin;
imgOut.pixelData = reshape(matrixData, imgOut.metaData.sizes);

disp('imgOut = ');
disp(imgOut);
disp('imgOut metaData = ');
disp(imgOut.metaData);
nrrdwrite(fileName, imgOut);
disp('Wrote file');
disp(fileName);
