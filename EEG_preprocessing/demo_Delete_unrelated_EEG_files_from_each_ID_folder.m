%% demo_Delete_unrelated_files_from_each_ID_folder
%   During EEG preprocessing analysis, there are some EEG files need to 
%   delete for big disk storage 

%


clc
clear
close all

tic
Path = 'E:\Resting_EEG_data_Preprocessing\Redeal_Dubin_Total27_20190827\Stage04_Follow_up_of_Resting';
cd(Path)
listing = dir(Path);
filename = {listing.name};
filename = filename(3:end);
filename = filename';
SubNum = length(filename);

for sub_num = 1:SubNum
    subPath = strcat(Path,'\',char(filename(sub_num)));
    cd(subPath)
    Filelist = dir(subPath);

    delete('Step03_Reref_filt_ICA.fdt','Step03_Reref_filt_ICA.set','Step04_After_ICA_rejEOG.fdt', 'Step04_After_ICA_rejEOG.set');
    delete('Step02_Artifacts_Rejected.fdt','Step02_Artifacts_Rejected.set');
    delete('Step03_Filt_40.fdt','Step03_Filt_40.set');


end
toc




