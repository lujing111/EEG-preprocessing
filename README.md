# EEG preprocessing in Matlab
EEG pre-processing mainly includes the following processes.
1. convert the raw data format into a .set file that can be read by EEGLAB
  (demo01_move_file_and_change_SET_format.m)
2. localize the electrode information of EEG data and convert the EEG reference to bilateral mastoid reference, then band-pass filtering (0.1-40HZ)    
  (demo02_Preprocess_of_Step1_before_visual_inspection.m )
3. remove bad segments by visual inspection and replace bad channels by interpolation 
  (can be achieved by Replace_Bad_Channels.m)
4. remove blink, muscle discharge by ICA 
  (demo04_Preprocess_of_Step3_Run_ICA_using_EEGLAB.m)
5. epoch the data and then perform baseline correction 
  (retrieve_marker_epoch_baseline_correct.m)

