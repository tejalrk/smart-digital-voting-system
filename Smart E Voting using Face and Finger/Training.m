for ijkl = 1:30
    
    I1 = imread(['Face\IMG (',num2str(ijkl),').jpg']);
    I2 = imread(['Finger\',num2str(ijkl),'.tif']);
    
    
    IR1 = imresize(I1,[256 256]);
    IR2 = imresize(I2,[256 256]);
    
    
    %  -- Face Detection -- %
    
    bw = im2bw(IR1);
    
    
    faceDetector = vision.CascadeObjectDetector();
    bbox            = step(faceDetector, IR1);
    
    h = insertObjectAnnotation(IR1,'rectangle',bbox,'Detected Face');
    %         figure('Name','Face Image');
    figure,
    
    imshow(h,[])
    
    for i=1:size(bbox,1)
        input2 = imcrop(IR1,bbox(i,:));
        imwrite(input2,['Croped\',num2str(i),'.jpg']);
    end
    
    
    % =======================================================
    % Feature Extraction
    
    LBPimg = LBP((input2), [2,3]); % applying local binary pattern
    
    LBPfeature=imhist(LBPimg); % calculating the histogram features
    LBPfea = LBPfeature'; % generating the feature values
    LBPfea2 = LBPfea;
    
    LBP_Testfea1 = [LBPfea2];     % Test Feature Generation
    
    
    % -- Finger (Minutae) -- %
    
    J = im2bw(IR2);
    thin_bin_img = bwmorph(~J,'thin','inf');
    
    
    fun = @minutie;
    
    Bin_cent = nlfilter(thin_bin_img,[3 3],fun);
    % Termination
    LTerm = (Bin_cent==1);
    figure;
    % axes(handles.axes5);
    
    imshow(LTerm);
    LTerm_Lab = bwlabel(LTerm);
    propTerm = regionprops(LTerm_Lab,'Centroid');
    CentroidTerm = round(cat(1,propTerm(:).Centroid));
    %         figure(4);
    % axes(handles.axes5);
    imshow(~Bin_cent);
    
    
    LTermLab=bwlabel(LTerm);
    propTerm=regionprops(LTermLab,'Centroid');
    CentroidTerm=round(cat(1,propTerm(:).Centroid));
    %         figure(4);
    % -------------------------------------------------------------------------
    
    
    imshow(~Bin_cent);
    % set(gcf,'position',[200 40 600 600]);
    LBif=(Bin_cent==3);
    LBifLab=bwlabel(LBif);
    propBif=regionprops(LBifLab,'Centroid','Image');
    CentroidBif=round(cat(1,propBif(:).Centroid));
    
    Trainfea(ijkl,:) = [LBP_Testfea1 CentroidBif(1:10) CentroidBif(1:10,2)'];
    
    close all
    clc
    ijkl
end

save Trainfea Trainfea

