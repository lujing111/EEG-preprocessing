addpath C:\Users\Administrator\Documents\MATLAB\Add-Ons\eeglab_current\eeglab14_1_2b
eeglab;


Path = 'E:\child_task_AV';
dname = uigetdir(Path);
listing = dir(dname);
filename = {listing.name};
filename = filename(3:end);
filename = filename';
SubNum = length(filename);

for number = 1:SubNum
    
    SubPath = strcat('D:\adult_task_AV\',char(filename(number)));   % The path of each subject's EEG data in A/AV0/AV200 folder
    cd(SubPath)
    SubName = char('AV_EYE.cnt');
    %SubName = SubName(5:end);
    %SubName = strcat(SubName,'AV_EYE.cnt');
    
   %%1 transform .cnt to .set
    
    EEG = pop_loadcnt(SubName,'dataformat', 'auto', 'memmapfile', '');
    EEG = eeg_checkset( EEG );
    NewName = strcat(SubName(1:end-4),'.set');
    EEG = pop_saveset( EEG, 'filename',NewName,'filepath',SubPath);
    EEG = eeg_checkset( EEG );

    %%2 load .set file
    EEG = pop_loadset('filename',NewName,'filepath',SubPath);
    EEG = eeg_checkset( EEG );    
    
     %% 3Filter. Notch 50Hz; Highpass 0.5Hz;lowpass 40HZ
    EEG  = pop_basicfilter( EEG,  1:EEG.nbchan, 'Boundary', 'boundary', 'Cutoff',  50, 'Design', 'notch', 'Filter', 'PMnotch', 'Order',  180, 'RemoveDC', 'on' ); 
    EEG = eeg_checkset( EEG );
    EEG  = pop_basicfilter( EEG,  1:EEG.nbchan, 'Boundary', 'boundary', 'Cutoff',  0.5, 'Design', 'butter', 'Filter', 'highpass', 'Order',  2); 
    EEG = eeg_checkset( EEG );

    %%4 channel location & rereference
    EEG=pop_chanedit(EEG, 'lookup','C:\\Users\\Administrator\\Documents\\MATLAB\\Add-Ons\\eeglab_current\\eeglab14_1_2b\\plugins\\dipfit2.3\\standard_BESA\\standard-10-5-cap385.elp');
    EEG = eeg_checkset( EEG );
    EEG = pop_select( EEG,'nochannel',{'HEO' 'VEO' 'M1' 'M2'});
    EEG = eeg_checkset( EEG );
    %EEG = pop_reref( EEG, [33 43] );
    %EEG = eeg_checkset( EEG );

    %EEG = pop_select( EEG,'nochannel',{'HEO' 'VEO' 'M1' 'M2' 'REF'});
   % EEG = eeg_checkset( EEG );
    EEG  = pop_basicfilter( EEG,  1:EEG.nbchan, 'Boundary', 'boundary', 'Cutoff',  40, 'Design', 'fir', 'Filter', 'lowpass', 'Order',  36); 
    EEG = eeg_checkset( EEG );
    
   
    %% save EEG data
    NewName = strcat('Step01_before_visual_inspection','.set');
    EEG = pop_saveset( EEG, 'filename',NewName,'filepath',SubPath);
    EEG = eeg_checkset( EEG );

end