%% Replace bad channels through Script
%   Room 9417, 20190812, ASAP


clc
clear
close all

tic
%%
Path = 'D:\ASAP_Files\EEGLAB\Resting_EEG_Data_deal_files';
cd(Path)
Excel_name = 'Resting_Bad_channels_record.xlsx';   
[NUM,TXT,RAW] = xlsread(Excel_name,'Stage04_Follow_up_of_Resting');
sub = size(TXT,1);

for sub_num = 2:sub   % Because the first row is the title, so the first ID name bigins from the 2end row 
    Data_path = ['E:\Resting_EEG_data_Preprocessing\Stage04_Follow_up_of_Resting\' TXT{sub_num,1}(2:end-1)];
    cd(Data_path)
    EEG = pop_loadset('filename','Step03_Filt_40.set','filepath',Data_path);
    EEG = eeg_checkset( EEG );
    
    %% Replace the bad channels 
    if RAW{sub_num,2} == 0 %|| isnan(RAW{sub_num,2})   % isnan: True for Not-a-Number;   || --> represent OR relationship.
    else
        Bad_channels = RAW{sub_num,2};      % Bad channels which needed to be replaced 
        if strcmp(class(Bad_channels),'double')     % Bad_channels' format is double, and we need change it into cell format
           Bad_channels = num2cell(Bad_channels);
           str2 =TXT{sub_num,3};
           Replace_channels = regexp(str2, ';', 'split');    % The good channels which used to replace the bad channels
           bad_chan_num = length(Bad_channels);           
           for bad_num = 1:bad_chan_num
                bad_chan = cell2mat(Bad_channels(bad_num));
                replace_chan = str2num(cell2mat(Replace_channels(bad_num)));
                EEG.data(bad_chan,:) = mean(EEG.data(replace_chan,:));
           end
        else
            Bad_channels = regexp(Bad_channels, ';', 'split');  % Here, Bad_channels' format is cell
            str2 =TXT{sub_num,3};
            Replace_channels = regexp(str2, ';', 'split');    % The good channels which used to replace the bad channels
            bad_chan_num = length(Bad_channels);
            for bad_num = 1:bad_chan_num
                bad_chan = str2num(cell2mat(Bad_channels(bad_num)));
                replace_chan = str2num(cell2mat(Replace_channels(bad_num)));
                EEG.data(bad_chan,:) = mean(EEG.data(replace_chan,:));
            end            
        end
    end
    
    %% Delete the bad channels 
    if RAW{sub_num,5} == 0
    else
        Deleted_channels = RAW{sub_num,5};     % Bad channels which needed to be deleted
        if strcmp(class(Deleted_channels),'double')
            Deleted_channels = num2str(Deleted_channels);
            Deleted_channels = strcat('B',Deleted_channels);    % For example:B107
            EEG = pop_select( EEG,'nochannel',{Deleted_channels});
            EEG = eeg_checkset( EEG );
        else
            Deleted_channels = regexp(Deleted_channels, ';', 'split');      % Here, Deleted_channels is cell format
            
            Deleted_channels_num = length(Deleted_channels);
            for i = 1:Deleted_channels_num
                Channel_num = Deleted_channels{i};
                Deleted_channels{i} = strcat('B',Channel_num);
            end
            for Deleted_num = 1:Deleted_channels_num   
                EEG = pop_select( EEG,'nochannel',{Deleted_channels{Deleted_num}});   
                EEG = eeg_checkset( EEG );
            end
        end
    end
    
    EEG = pop_saveset( EEG, 'filename','Step02_Artifacts_Rejected.set','filepath',Data_path);
    EEG = eeg_checkset( EEG );
end
toc



