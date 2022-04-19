%%   Preprocess_of_Step3_Run ICA using EEGLAB
%   including: Here, I only run the ICA step; then I save the results.
%            After this step, I need to reject the artifacts through ICs maps.
%   Tianjin Normal University, 20190718

clc
clear
close all

tic
%%
Path = 'F:\Training_exg\ASAP_Adult_TF_Analyze\Exg_Pre';
dname = uigetdir(Path);
listing = dir(dname);
filename = {listing.name};
filename = filename(3:end);
SubNum = length(filename);

for number = 1:SubNum
    subPath = strcat('F:\Training_exg\ASAP_Adult_TF_Analyze\Exg_Pre\AV200\',char(filename(number)));   % The path of each subject's EEG data in A/AV0/AV200 folder
    cd(subPath)
    Filelist = dir(subPath);
    subName = 'Step03_reref_filtered.set';
    
    %% load .set file
    EEG = pop_loadset('filename',subName,'filepath',subPath);
    EEG = eeg_checkset( EEG );

    %% Run ICA using EEGLAB
    EEG = pop_runica(EEG, 'extended',1,'interupt','on');
    EEG = eeg_checkset( EEG );

    %% save EEG data
    NewName = strcat('Step04_RunICA','.set');
    EEG = pop_saveset( EEG, 'filename',NewName,'filepath',subPath);
    EEG = eeg_checkset( EEG );

end
toc