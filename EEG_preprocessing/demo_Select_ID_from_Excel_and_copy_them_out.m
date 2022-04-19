%% demo_Select_ID_from_Excel_and_copy_them_out
% Select participants'ID data from Excel file, and then copy them from one disk to the other
% 20190819, Room 9417

tic




clc
clear
close all


Path = 'D:\ASAP_Files\EEGLAB\Resting_EEG_Data_deal_files';
cd(Path)
Excel_name = 'Overview_of_Resting_Data_Preprocessing_Reject_ICA.xlsx';   
[NUM,TXT,RAW] = xlsread(Excel_name,'Stage03_Postest_of_Resting','A134:A151');      % Need to change 
sub = size(TXT,1);
for sub_num = 1:sub
    Data_path = ['E:\Resting_EEG_data_Preprocessing\Stage03_Postest_of_Resting\' TXT{sub_num,1}(2:end-1)];

    goalPathName = Data_path;
%     desPathName = strcat('E:\Resting_EEG_data_Preprocessing\LST_Part_ICA_reject_Myself_Part\Stage03_ICA_Rejected_Myself_Part\', TXT{sub_num,1}(2:end-1), '\');      % Need to change 
    desPathName = strcat('F:\LST_Part_ICA_Reject_20190827\Stage03_Postest_of_Resting\', TXT{sub_num,1}(2:end-1), '\');      % Need to change 
    copyfile(goalPathName, desPathName) 

%     goalPathName = Data_path;
%     desPathName = strcat('F:\LST_Part_ICA_reject\Stage02_ICA_Rejected\', TXT{sub_num,1}(2:end-1), '\');      % Need to change 
%     movefile(goalPathName, desPathName)       
end



clc
clear
close all


Path = 'D:\ASAP_Files\EEGLAB\Resting_EEG_Data_deal_files';
cd(Path)
Excel_name = 'Overview_of_Resting_Data_Preprocessing_Reject_ICA.xlsx';   
[NUM,TXT,RAW] = xlsread(Excel_name,'Stage04_Follow_up_of_Resting','A109:A128');      % Need to change 
sub = size(TXT,1);
for sub_num = 1:sub
    Data_path = ['E:\Resting_EEG_data_Preprocessing\Stage04_Follow_up_of_Resting\' TXT{sub_num,1}(2:end-1)];

    goalPathName = Data_path;
    desPathName = strcat('F:\LST_Part_ICA_Reject_20190827\Stage04_Follow_up_of_Resting\', TXT{sub_num,1}(2:end-1), '\');      % Need to change 
    copyfile(goalPathName, desPathName)

%     goalPathName = Data_path;
%     desPathName = strcat('E:\Resting_EEG_data_Preprocessing\Stage04_ICA_Rejected_Myself_Part\', TXT{sub_num,1}(2:end-1), '\');      % Need to change 
%     movefile(goalPathName, desPathName)       
end

toc

















