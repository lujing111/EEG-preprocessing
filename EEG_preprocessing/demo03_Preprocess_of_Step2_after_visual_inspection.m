%%   Preprocess_of_Step2_after_visual_inspection
%   including: 1/Select data and down the analyzed electrodes to 70   
%              2/40Hz Low Pass
%              3/Run ICA
%   Room 9417, 20190812, ASAP

clc
clear
close all

tic
%%
Path = 'J:\Adult_open1\';
% dname = uigetdir(Path);
listing = dir(Path);
filename = {listing.name};
filename = filename(3:end);
SubNum = length(filename);

for number = 1:SubNum
    subPath = strcat('J:\Adult_open1\',char(filename(number)));   % The path of each subject's EEG data in A/AV0/AV200 folder
    cd(subPath)
    Filelist = dir(subPath);
    subName = 'Step02_Artifacts_Rejected.set';   % Get the EEG data .SET file name
%     subName = char(subName(8));   % Get the EEG data .SET file name
    
    %% load .set file
    EEG = pop_loadset('filename',subName,'filepath',subPath);
    EEG = eeg_checkset( EEG );

    %% 1/Select data and down the analyzed electrodes to 64
    % Method 1.
    EEG = pop_select( EEG,'nochannel',{'B5' 'B7' 'B8' 'B10' 'B12' 'B14' 'B15' 'B17' 'B18' 'B20' 'B21' 'B25' 'B31' 'B35'...
        'B39' 'B40' 'B43' 'B48' 'B49' 'B50' 'B53' 'B54' 'B56' 'B59' 'B61' 'B63' 'B66' 'B68' 'B69' 'B71' 'B73' 'B74' 'B76'...
        'B78' 'B79' 'B80' 'B81' 'B82' 'B84' 'B86' 'B88' 'B89' 'B91' 'B94' 'B99' 'B101' 'B106' 'B107' 'B109' 'B110' 'B113'...
        'B115' 'B118' 'B119' 'B120' 'B125' 'B126' 'B127' 'B128'});
    
    % Method 2. I did not run it successfully and always got the following error: Index exceeds matrix dimensions. 
%     for Chge_Num = 1:EEG.nbchan
%         
%         name_char = EEG.chanlocs(Chge_Num).labels;
%         loc_chan = find(name_char(:,1) == 'B');
%         remove_chan = name_char(loc_chan,:);
%         remove_chan = cellstr(remove_chan);
%         EEG = pop_select(EEG,'nochannel',remove_chan);
%         
%     end

    %% 2/Filter. Lowpass 40Hz
    EEG  = pop_basicfilter( EEG,  1:EEG.nbchan, 'Boundary', 'boundary', 'Cutoff',  40, 'Design', 'fir', 'Filter', 'lowpass', 'Order',  36); 
    EEG = eeg_checkset( EEG );
    
    %% 3/Run ICA using EEGLAB
    EEG = pop_runica(EEG, 'extended',1,'interupt','on');
    EEG = eeg_checkset( EEG );

    %% save EEG data
    NewName = strcat('Step03_Reref_filt_ICA','.set');
    EEG = pop_saveset( EEG, 'filename',NewName,'filepath',subPath);
    EEG = eeg_checkset( EEG );


end
toc

