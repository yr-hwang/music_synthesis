% 4

load('bach_fugue.mat');

fs = 11025; 
bpm = 80;
bps = bpm / 60;
spb = 1 / bps;
spp = spb / 4;
attack_time = 0.1;     % Time taken for the sound to reach its maximum amplitude
decay_time = 0.2;      % Time taken for the sound to decay to the sustain level
sustain_level = 0.6;   % Amplitude level during the sustain phase
release_time = 0.3;    % Time taken for the sound to fade away after key release

total_duration_pulses = max(theVoices(1).startPulses);
song_waveform = zeros(1, round(total_duration_pulses * fs * spp) + 5000);

for i = 1:length(theVoices)
    noteNumbers = theVoices(i).noteNumbers;
    startPulses = theVoices(i).startPulses;
    durations = theVoices(i).durations;

    for j = 1:length(noteNumbers)
        keynum = noteNumbers(j);
        start_pulse = startPulses(j);
        duration_pulse = durations(j);
        
        start_time = start_pulse * spp;
        duration_sec = duration_pulse * spp;
        
        current_note_waveform = key2note(1, keynum, duration_sec, attack_time, decay_time, sustain_level, release_time);

        start_index = round(start_time * fs) + 1;
        end_index = start_index + length(current_note_waveform) - 1;
        song_waveform(start_index:end_index) = song_waveform(start_index:end_index) + current_note_waveform;
    end
end

soundsc(song_waveform, fs);

spectrogram(song_waveform, 512, [], 512, fs, 'yaxis');
