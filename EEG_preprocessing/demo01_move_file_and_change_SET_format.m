%  move RAW.data file to a new folder, and save all of them as .set format; 
%   20190810, Room 9417
clc
clear
close all

tic
%%   move RAW.data file to a new folder, and save all of them as .set format;
Path = 'E:\child_task_AV_raw';
listing = dir(Path);
filename = {listing.name};
filename = filename(3:end);   % Becasue S01 and S02 in group A has been deal, so we begin it from S03 which started as index 5 in the data list.
filename = filename';
SubNum = length(filename);

for number = 1:SubNum
    cd(Path)
    RestingData_FileName = char(filename(119));
    subName = RestingData_FileName(1:12);   % close:23; open:22
    
    EEG = pop_readegi(RestingData_FileName, [],[],'auto');
    EEG = eeg_checkset( EEG );
    NewPath = strcat('E:\child_task_AV\',subName);    % Save each EEG data according to its folder name
    mkdir(NewPath);
    NewName = strcat(subName,'.set');
    EEG = pop_saveset( EEG, 'filename',NewName,'filepath',NewPath);
    EEG = eeg_checkset( EEG );
    
end
toc


clc
clear
close all

tic
%%   move RAW.data file to a new folder, and save all of them as .set format;
Path = 'H:\BNU\Raw_Data_of_EEG_Resting\Stage01_Pretest_of_Resting\Music_close';
listing = dir(Path);
filename = {listing.name};
filename = filename(3:end);   % Becasue S01 and S02 in group A has been deal, so we begin it from S03 which started as index 5 in the data list.
filename = filename';
SubNum = length(filename);

for number = 1:SubNum
    cd(Path)
    RestingData_FileName = char(filename(number));
    subName = RestingData_FileName(1:23);   % close:23; open:22
    
    EEG = pop_readegi(RestingData_FileName, [],[],'auto');
    EEG = eeg_checkset( EEG );
    NewPath = strcat('I:\Resting_EEG_data_Preprocessing\Stage01_Pretest_of_Resting\Music_close\',subName);    % Save each EEG data according to its folder name
    mkdir(NewPath);
    NewName = strcat(subName,'.set');
    EEG = pop_saveset( EEG, 'filename',NewName,'filepath',NewPath);
    EEG = eeg_checkset( EEG );
    
end
toc







