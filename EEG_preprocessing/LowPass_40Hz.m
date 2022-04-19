tic

clc
clear
close all

Path = 'E:\Resting_EEG_data_Preprocessing\Redeal_Dubin_Total27_20190827\Stage01_Pretest_of_Resting';
% dname = uigetdir(Path);
listing = dir(Path);
filename = {listing.name};
filename = filename(3:end);
filename = filename';
SubNum = length(filename);

for number = 1:SubNum
    subPath = strcat(Path,'\',char(filename(number)));   % The path of each subject's EEG data in A/AV0/AV200 folder
    cd(subPath)
    Filelist = dir(subPath);
    subName = 'Step01_before_visual_inspection.set';
    
    %% load .set file
    EEG = pop_loadset('filename',subName,'filepath',subPath);
    EEG = eeg_checkset( EEG );
    %% Filter. Lowpass 40Hz
    EEG  = pop_basicfilter( EEG,  1:EEG.nbchan, 'Boundary', 'boundary', 'Cutoff',  40, 'Design', 'fir', 'Filter', 'lowpass', 'Order',  36); 
    EEG = eeg_checkset( EEG );    
    
    NewName = strcat('Step03_Filt_40','.set');
    EEG = pop_saveset( EEG, 'filename',NewName,'filepath',subPath);
    EEG = eeg_checkset( EEG );    
    
end

clc
clear
close all

Path = 'E:\Resting_EEG_data_Preprocessing\Redeal_Dubin_Total27_20190827\Stage02_Midtest_of_Resting';
% dname = uigetdir(Path);
listing = dir(Path);
filename = {listing.name};
filename = filename(3:end);
filename = filename';
SubNum = length(filename);

for number = 1:SubNum
    subPath = strcat(Path,'\',char(filename(number)));   % The path of each subject's EEG data in A/AV0/AV200 folder
    cd(subPath)
    Filelist = dir(subPath);
    subName = 'Step01_before_visual_inspection.set';
       
    %% load .set file
    EEG = pop_loadset('filename',subName,'filepath',subPath);
    EEG = eeg_checkset( EEG );
    %% Filter. Lowpass 40Hz
    EEG  = pop_basicfilter( EEG,  1:EEG.nbchan, 'Boundary', 'boundary', 'Cutoff',  40, 'Design', 'fir', 'Filter', 'lowpass', 'Order',  36); 
    EEG = eeg_checkset( EEG );    
    
    NewName = strcat('Step03_Filt_40','.set');
    EEG = pop_saveset( EEG, 'filename',NewName,'filepath',subPath);
    EEG = eeg_checkset( EEG );    
    
end


clc
clear
close all

Path = 'E:\Resting_EEG_data_Preprocessing\Redeal_Dubin_Total27_20190827\Stage03_Postest_of_Resting';
% dname = uigetdir(Path);
listing = dir(Path);
filename = {listing.name};
filename = filename(3:end);
filename = filename';
SubNum = length(filename);

for number = 1:SubNum
    subPath = strcat(Path,'\',char(filename(number)));   % The path of each subject's EEG data in A/AV0/AV200 folder
    cd(subPath)
    Filelist = dir(subPath);
    subName = 'Step01_before_visual_inspection.set';
       
    %% load .set file
    EEG = pop_loadset('filename',subName,'filepath',subPath);
    EEG = eeg_checkset( EEG );
    %% Filter. Lowpass 40Hz
    EEG  = pop_basicfilter( EEG,  1:EEG.nbchan, 'Boundary', 'boundary', 'Cutoff',  40, 'Design', 'fir', 'Filter', 'lowpass', 'Order',  36); 
    EEG = eeg_checkset( EEG );    
    
    NewName = strcat('Step03_Filt_40','.set');
    EEG = pop_saveset( EEG, 'filename',NewName,'filepath',subPath);
    EEG = eeg_checkset( EEG );    
    
end


clc
clear
close all

Path = 'E:\Resting_EEG_data_Preprocessing\Redeal_Dubin_Total27_20190827\Stage04_Follow_up_of_Resting';
% dname = uigetdir(Path);
listing = dir(Path);
filename = {listing.name};
filename = filename(3:end);
filename = filename';
SubNum = length(filename);

for number = 1:SubNum
    subPath = strcat(Path,'\',char(filename(number)));   % The path of each subject's EEG data in A/AV0/AV200 folder
    cd(subPath)
    Filelist = dir(subPath);
    subName = 'Step01_before_visual_inspection.set';
       
    %% load .set file
    EEG = pop_loadset('filename',subName,'filepath',subPath);
    EEG = eeg_checkset( EEG );
    %% Filter. Lowpass 40Hz
    EEG  = pop_basicfilter( EEG,  1:EEG.nbchan, 'Boundary', 'boundary', 'Cutoff',  40, 'Design', 'fir', 'Filter', 'lowpass', 'Order',  36); 
    EEG = eeg_checkset( EEG );    
    
    NewName = strcat('Step03_Filt_40','.set');
    EEG = pop_saveset( EEG, 'filename',NewName,'filepath',subPath);
    EEG = eeg_checkset( EEG );    
    
end








toc