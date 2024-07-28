function [rawim, XYZ2Cam, wbcoeffs] = readdng(filename)

    % read the RAW image
    obj = Tiff(filename, 'r');
    offsets = getTag(obj, 'SubIFD');
    setSubDirectory(obj, offsets(1));
    rawim = read(obj);
    close(obj);

    % read the useful metadata
    meta_info = imfinfo(filename);

    % extract useful metadata
    y_origin = meta_info.SubIFDs{1}.ActiveArea(1) + 1;
    x_origin = meta_info.SubIFDs{1}.ActiveArea(2) + 1;
    width = meta_info.SubIFDs{1}.DefaultCropSize(1);
    height = meta_info.SubIFDs{1}.DefaultCropSize(2);
    blacklevel = meta_info.SubIFDs{1}.BlackLevel(1);
    whitelevel = meta_info.SubIFDs{1}.WhiteLevel;
    wbcoeffs = (meta_info.AsShotNeutral).^-1;
    wbcoeffs = wbcoeffs / wbcoeffs(2);
    XYZ2Cam = meta_info.ColorMatrix2;
    XYZ2Cam = reshape(XYZ2Cam, 3, 3)';

    % perform point transformation to normalize image
    rawim = double(rawim(y_origin:y_origin+height-1, x_origin:x_origin+width-1));
    rawim = (rawim - blacklevel) / (whitelevel - blacklevel);
    rawim = max(0, min(rawim, 1));

end
