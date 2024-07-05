# Music Synthesis

This project aims to perform music synthesis with sinusoids on Fugue #2 for the Well-Tempered Clavier by Bach. 

## Fundamental Theories
### 1. Theory of Sampling
![image](https://github.com/yr-hwang/music_synthesis/assets/173549924/15b7ea42-a834-42a3-bc17-6f5f768d3777)

The figure above illustrates the overall process of sampling and reconstruction of a continuous-time signal. Sampling is the process of obtaining a discrete-time signal *x[n]* from the continuous-time signal *x(t)*. The sampling rate, *f<sub>s</sub>*, is defined as the number of samples per second. The Sampling Theorem states that for an input signal *x(t)* that consists of a sum of sine waves, the output wave *y(t)* will be equal to *x(t)* if the sampling rate is more than twice the highest frequency, *f<sub>max</sub>* in the input.

### 2. Piano Keyboard
![image](https://github.com/yr-hwang/music_synthesis/assets/173549924/d76ab28c-d01b-4bfb-af3d-15e855ddaeb3)

The figure above displays the layout of a piano keyboard. Each octave has 12 notes, which consists of 7 white keys and 5 black keys. The ratio between the frequencies of successive notes is 2<sup>1/12</sup>. The A above the middle-C is known as A-440 as it has a frequency of 440Hz, and is used as a reference note. Using the ratio between the frequencies of the notes and the location of the key from A-440, the frequencies of the notes anywhere on the piano keyboard can be calculated.


![image](https://github.com/yr-hwang/music_synthesis/assets/173549924/d073c920-600b-4ad3-8ce2-ff3b337d6970)

The figure above displays the musical notation which shows the relative timing (ie. half, quarter, or eighth) of which notes will be played.

## key2note.m
An M-file named key2note.m was created to write two functions, key2note and ADSREnvelope.

The key2note function allows a desired note to be played for a given duration. The frequency of the desired note has to be calculated, and with that frequency, the sinusoid of the real part of the complex exponential is generated.

![image](https://github.com/yr-hwang/music_synthesis/assets/173549924/977e2a5f-bf00-4b45-a42d-7d5cf967d381)

The ADSREnvelope function adds an "envelope" to the sinusoid signal to improve the sound quality and reduce artificialness. With an envelope, the tone signal will fade in and fade out slowly. The envelope function, *E(t)* is divided into four sections: attack (A), delay (D), sustain (S), and release (R). The profile for *E(t)* is shown in the figure above.

## music_synthesis.m
The actual synthesis of musical notes from Fugue #2 for the Well-Tempered Clavier is done in this M-file. A sampling frequency of 11025 samples/s and BPM of 80 was used. The frequency and the total time duration of each note was determined. The sound output was played using soundsc(xx,fs) and the spectrogram with a window length of 512 was plotted.
