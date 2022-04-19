addpath C:\Users\lujing\Documents\MATLAB\Add-Ons\eeglab_current\eeglab14_1_2b;
eeglab;

path = 'E:\child_task_AV';
file = dir(path);
file_name = {file.name};
file_name = file_name(3:end); 
file_name = file_name';
sub = length(file_name);

for number = 1
    subPath = strcat('E:\child_task_AV\',char(file_name(number)));   % The path of each subject's EEG data in A/AV0/AV200 folder
    cd(subPath)
    Filelist = dir(subPath);
    subName = 'Step05_After_ICA_rejEOG.set';
    
     %% load .set file
    EEG = pop_loadset('filename',subName,'filepath',subPath);
    EEG = eeg_checkset( EEG );
    EEG = pop_epoch( EEG, {  'DI10'  'DI11'  'DI12'  'DI13'  'DI14'  'DI15'  'DI16'  'DI17'  'DI18'  'DI19'  'DI20'  'DI21'  'DI22'  'DI23'  'DI24'  'DI25'  'DI26'  'DI27'  'DI28'  'DI29'  'DI30'  'DI31'  'DI32'  'DI33'  'DI34'  'DIN1'  'DIN2'  'DIN3'  'DIN4'  'DIN5'  'DIN6'  'DIN7'  'DIN8'  'DIN9'  }, [-0.5         0.5], 'newname', 'EGI file pruned with ICA epochs', 'epochinfo', 'yes');
    EEG = eeg_checkset( EEG );
    EEG = pop_rmbase( EEG, [-100    0]);
    EEG = eeg_checkset( EEG );
    
    %%save file
    savename = '1.set';
    EEG = pop_saveset( EEG, 'filename',savename,'filepath',subPath);
    EEG = eeg_checkset( EEG );
    data = EEG.data;
end
