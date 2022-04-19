Path = 'E:\resting_close1_yuanyuan\Adult_close1\';
% dname = uigetdir(Path);
listing = dir(Path);
filename = {listing.name};
filename = filename(4:end);
SubNum = length(filename);

for number = 1:SubNum
    subPath = strcat('E:\resting_close1_yuanyuan\Adult_close1\',char(filename(number)));   % The path of each subject's EEG data in A/AV0/AV200 folder
    cd(subPath)
    Filelist = dir(subPath);
    subName = 'Step02_Artifacts_Rejected.set';   % Get the EEG data .SET file name
%     subName = char(subName(8));   % Get the EEG data .SET file name
    
    %% load .set file
    EEG = pop_loadset('filename',subName,'filepath',subPath);
    EEG = eeg_checkset( EEG );
 %% 3/Run ICA using EEGLAB
    EEG = pop_runica(EEG, 'extended',1,'interupt','on');
    EEG = eeg_checkset( EEG );

    %% save EEG data
    NewName = strcat('Step03_Reref_filt_ICA','.set');
    EEG = pop_saveset( EEG, 'filename',NewName,'filepath',subPath);
    EEG = eeg_checkset( EEG );


end