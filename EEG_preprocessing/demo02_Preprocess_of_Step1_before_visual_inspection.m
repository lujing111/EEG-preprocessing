%%   Preprocess_of_Step1_before_visual_inspection
%   including: 1/Read channel locations  2/Add Cz electrode to raw EEG data
%              3/Change electrode's name (from number to name)  4/Re-reference (average method) 
%              5/50Hz Notch£»0.5 High Pass
%   Room 9417, 20190811, ASAP

clc
clear
close all

tic
%%
Path = 'I:\Resting_EEG_data_Preprocessing\Stage01_Pretest_of_Resting';
dname = uigetdir(Path);
listing = dir(dname);
filename = {listing.name};
filename = filename(3:end);
SubNum = length(filename);

for number = 1:SubNum
    subPath = strcat('I:\Resting_EEG_data_Preprocessing\Stage01_Pretest_of_Resting\Music_close\',char(filename(number)));   % The path of each subject's EEG data in A/AV0/AV200 folder
    cd(subPath)
    Filelist = dir(subPath);
    subName = {Filelist.name};
    subName = char(subName(4));   % Get the EEG data .SET file name
    
    
    %% load .set file
    EEG = pop_loadset('filename',subName,'filepath',subPath);
    EEG = eeg_checkset( EEG );
    
    
    %% 1/Read channel locations & 2/Add Cz electrode to raw EEG data
    EEG.nbchan = 129;
    EEG.data(129,:) = mean([EEG.data(7,:);EEG.data(31,:);EEG.data(80,:);EEG.data(106,:)]);
    EEG = pop_chanedit(EEG, 'load',{'D:\EEGLAB_13_4_4b\sample_locs\GSN-HydroCel-129_ASAP.sfp' 'filetype' 'autodetect'});
    EEG.urchanlocs(129).labels = EEG.chanlocs(129).labels;
    EEG.urchanlocs(129).Y = EEG.chanlocs(129).Y;
    EEG.urchanlocs(129).X = EEG.chanlocs(129).X;
    EEG.urchanlocs(129).Z = EEG.chanlocs(129).Z;
    EEG.urchanlocs(129).sph_theta = EEG.chanlocs(129).sph_theta;
    EEG.urchanlocs(129).sph_phi = EEG.chanlocs(129).sph_phi;
    EEG.urchanlocs(129).sph_radius = EEG.chanlocs(129).sph_radius;
    EEG.urchanlocs(129).theta = EEG.chanlocs(129).theta;
    EEG.urchanlocs(129).radius = EEG.chanlocs(129).radius;
%    EEG.urchanlocs(129).sph_theta_besa = 0;
%    EEG.urchanlocs(129).sph_phi_besa = 90;   
    EEG.urchanlocs(129).type = EEG.chanlocs(129).type;
    
    
    %% 3/Change electrode's name (from number to name)
    Name_Electrodes = {'F10','AF8','AF4','F2','B5','FCz','B7','B8','FP2','B10','Fz','B12','FC1','B14','B15','AFz',...
    'B17','B18','F1','B20','B21','FP1','AF3','F3','B25','AF7','F5','FC5','FC3','C1','B31','F9',...
    'F7','FT7','B35','C3','CP1','FT9','B39','B40','C5','CP3','B43','T9','T7','TP7','CP5','B48','B49',...
    'B50','P5','P3','B53','B54','CPz','B56','TP9','P7','B59','P1','B61','Pz','B63','P9','PO7',...
    'B66','PO3','B68','B69','O1','B71','POz','B73','B74','Oz','B76','PO4','B78','B79','B80','B81',...
    'B82','O2','B84','P2','B86','CP2','B88','B89','PO8','B91','P4','CP4','B94','P10','P8','P6',...
    'CP6','B99','TP10','B101','TP8','C6','C4','C2','B106','B107','T8','B109','B110','FC4','FC2','B113','T10','B115','FT8','FC6','B118','B119','B120',...
    'FT10','F8','F6','F4','B125','B126','B127','B128','Cz'};
    for Chge_Num = 1:EEG.nbchan   
        EEG.chanlocs(Chge_Num).labels = Name_Electrodes{Chge_Num};
        EEG.chanlocs(Chge_Num).urchan = Chge_Num;
    end
    
    
    %% 4/Rereference. Average method
    EEG = pop_reref(EEG,[]);
    EEG = eeg_checkset( EEG );    


    %% 5/Filter. Notch 50Hz; Highpass 0.5Hz;
    EEG  = pop_basicfilter( EEG,  1:EEG.nbchan, 'Boundary', 'boundary', 'Cutoff',  50, 'Design', 'notch', 'Filter', 'PMnotch', 'Order',  180, 'RemoveDC', 'on' ); 
    EEG = eeg_checkset( EEG );
    EEG  = pop_basicfilter( EEG,  1:EEG.nbchan, 'Boundary', 'boundary', 'Cutoff',  0.5, 'Design', 'butter', 'Filter', 'highpass', 'Order',  2); 
    EEG = eeg_checkset( EEG );

    
    %% save EEG data
    NewName = strcat('Step01_before_visual_inspection','.set');
    EEG = pop_saveset( EEG, 'filename',NewName,'filepath',subPath);
    EEG = eeg_checkset( EEG );

end
toc







