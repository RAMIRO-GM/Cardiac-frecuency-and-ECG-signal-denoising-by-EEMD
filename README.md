# Cardiac-frecuency-and-ECG-signal-denoising-by-EEMD
ECG signal denoising using Ensemble Empirical Mode Decomposition and R peak detection (cardiac frequency) using Hilbert Transform.

The aim of this project is to filter and denoise a physiological signal (in this case I opted for cardiac signals ECG), by using a new approach of Ensemble Empirical Mode Decomposition (a novel approach for denoising biological signals). Moreover, to register the cardiac frequency by using Hilbert Transform.


## FILE STRUCTURE:

*Axcor----To obtain the correlation index of signals. Optional to use, to compare between signals after applying a filter.

*ecg.mat---Real ecg example #1.

*ecg1.mat---Real ecg example #2.

*eemd.m--- EEMD function. See the description below.

*EEMDdenosisingHilbert.m---Main source code. The file to run. It has the implementation of the functions with the ecg signals.

*emax--Returns the  max points and their coordinates

*emin--Returns the  min points and their coordinates

*extrema--this function ususally used for finding spline envelope (not used).

*peakseek---It finds the peaks in a certain scope (not used, because Hilbert Transform is more accurate).

```
Example:
ecg=load ('ecg1.mat');          % loading the signal 
ecg=struct2cell(ecg);
ecg=cell2mat(ecg);
ecg = (ecg - 1024)/200;     % you have to remove "base" and "gain"
```

### EEMD code was obtain from:

https://github.com/benpolletta/HHT-Tutorial/blob/master/HuangEMD/eemd.m#L12
HHT-Tutorial/HuangEMD/eemd.m  (GITHUB)
 References:   
  Wu, Z., and N. E Huang (2008), 
  Ensemble Empirical Mode Decomposition: a noise-assisted data analysis method. 
  Advances in Adaptive Data Analysis. Vol.1, No.1. 1-41.  

 code writer: Zhaohua Wu. 
 footnote:S.C.Su 2009/03/04

## EEMD function

The EEMD descompose the signals into Intrinsic Mode Functions, which a few are taken to reconstruct the signal and remove noise and artifacts.
To apply the EEMD function:
```
Example:
imf=eemd(ecg1,.2,70); %Apply the EEMD to the noisy signal 
Arguments: ecg1:signal to be filtered .2->ratio of the standard deviation, 70->ensemble number
```
These values where set according to literature.

## Filtering and denoising the ECG signal
To filter the signal I apply a 4th order digital butterworth bandpass and the eemd.
```
%% ECG signal denoising
imf=eemd(ecg1,.2,70); %Apply the EEMD to the noisy signal .2->ratio of the standard deviation 70->ensemble number
imfs=imf';             %transpose the imf's matrix
reconstruction=imfs(4,:)+imfs(5,:)+imfs(6,:);  %We consider that these 3 imf's possess the important information

%4 order Butterworth filter bandpass .05-230Hz. 
fclowpass=230; % Low pass cut-off frequency 230Hz
fchighpass=.05; % Low pass cut-off frequency .05Hz
filterorder=4;  %filter order

[b,a]=butter(filterorder,[filterorder*fchighpass/Fs,2*fclowpass/Fs]);
filtered_ECG=filter(b,a,reconstruction);
```
The Hilbert Transform is used to Emphasize the R peaks of the ECG and to have one unique r peak, as it was 
previously removed the noise and the artifacts.
## Image
The image depicts the initial raw physiological signal and the final filtered signal with the respective R peaks (cardiac Frequency), including the Hilbert Transform.
![1](https://user-images.githubusercontent.com/39096829/41690596-e78f25bc-74bb-11e8-8c8f-d1ddb0ae33d8.PNG) 
The following image shows the filtered/denoised ECG signal (Without the Hilbert Transform).
![filter](https://user-images.githubusercontent.com/39096829/41690753-a20da238-74bc-11e8-88e3-b2bbf23feed5.PNG)
