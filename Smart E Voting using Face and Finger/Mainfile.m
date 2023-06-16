clear all

close all

clc

warning off;

close all hidden;

% -- Getting Input Image -- %

[f,p] = uigetfile('Face\*.jpg');

if f == 0
    
    warndlg('You Have Cancelled');
    
else
    
    
    I1 = imread([p f]);
    
    figure(1);
    
    imshow(I1);
    
    title('Input Face Image','FontName',...
        'Times New Roman','Fontsize',12);
    
    [f,p] = uigetfile('Finger\*.jpg');
    
    if f == 0
        
        warndlg('You Have Cancelled');
        
    else
        
        I2 = imread([p f]);
        
        figure(2);
        
        imshow(I2);
        
        title('Input Finger Print Image','FontName',...
            'Times New Roman','Fontsize',12);
        
        
        IR1 = imresize(I1,[256 256]);
        IR2 = imresize(I2,[256 256]);
        
        figure(3),
        subplot(1,2,1);
        imshow(I1);
        
        title('Resized Image 1','FontName',...
            'Times New Roman','Fontsize',12);
        
        subplot(1,2,2);
        imshow(I2);
        
        title('Resized Image 2','FontName',...
            'Times New Roman','Fontsize',12);
        
        
        
        %  -- Face Detection -- %
        
        bw = im2bw(IR1);
        
        figure('Name','Face Image');
        imshow(bw);title('Binary Image');
        
        faceDetector = vision.CascadeObjectDetector();
        bbox            = step(faceDetector, IR1);
        
        h = insertObjectAnnotation(IR1,'rectangle',bbox,'Detected Face');
        figure('Name','Face Image');
        imshow(h,[])
        
        for i=1:size(bbox,1)
            input2 = imcrop(IR1,bbox(i,:));
            imwrite(input2,['Croped\',num2str(i),'.jpg']);
        end
        
        
        % =======================================================
        % Feature Extraction
        
        LBPimg = LBP((input2), [2,3]); % applying local binary pattern
        figure
        imshow(LBPimg);
        title('LBP Image 1');
        
        LBPfeature=imhist(LBPimg); % calculating the histogram features
        LBPfea = LBPfeature'; % generating the feature values
        LBPfea2 = LBPfea;
        
        LBP_Testfea1 = [LBPfea2];     % Test Feature Generation
        
        
        % -- Finger (Minutae) -- %
        
        J = im2bw(IR2);
        thin_bin_img = bwmorph(~J,'thin','inf');
        
        figure,
        imshow(~thin_bin_img);
        
        title('Thinned Binary Image','FontName',...
            'Times New Roman','Fontsize',12);
        
        fun = @minutie;
        
        Bin_cent = nlfilter(thin_bin_img,[3 3],fun);
        % Termination
        LTerm = (Bin_cent==1);
        figure;
        % axes(handles.axes5);
        
        imshow(LTerm);
        pause(1);
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
        pause(1)
        % axes(handles.axes6);
        imshow(~Bin_cent);
        % -------------------------------------------------------------------------
        % set(gcf,'position',[200 40 600 600]);
        hold on;
        %         figure(4);
        % axes(handles.axes6);
        
        title('Finger print Centroid');
        plot(CentroidTerm(:,1),CentroidTerm(:,2),'ro');
        
        figure;
        % axes(handles.axes7);
        
        imshow(~Bin_cent);
        % set(gcf,'position',[200 40 600 600]);
        hold on;
        LBif=(Bin_cent==3);
        LBifLab=bwlabel(LBif);
        propBif=regionprops(LBifLab,'Centroid','Image');
        CentroidBif=round(cat(1,propBif(:).Centroid));
        hold on;
        % figure(5);title('');
        plot(CentroidBif(:,1),CentroidBif(:,2),'bo');title('Centroid of Each Ridges');
        
        %         figure(6);
        % axes(handles.axes8);
        
        imshow(~Bin_cent);
        % set(gcf,'position',[200 40 600 600]);
        hold on;
        % axes(handles.axes1);
        %         figure(6)
        plot(CentroidTerm(:,1),CentroidTerm(:,2),'ro');
        hold on;
        %         figure(6);
        % axes(handles.axes8);
        
        plot(CentroidBif(:,1),CentroidBif(:,2),'bo');title('Centroid of Each Ridges');
        
        Testfea2 = [LBP_Testfea1 CentroidBif(1:10) CentroidBif(1:10,2)'];
        
        Testfeature = Testfea2;
        
        figure('Name','Test Features'),
        td = uitable('data',Testfeature);
        
    end
end
