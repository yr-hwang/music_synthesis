% 3.1

function xx = key2note(X, keynum, dur, attack_time, decay_time, sustain_level, release_time);
    fs = 11025; %-- or use 8000 Hz
    tt = 0:(1/fs):dur;
    t = linspace(0, dur, round(fs * dur));
    freqA4 = 440;
    keynumA4 = 40;
    freq_ratio = 2^(1/12);
    freq = freqA4*(2^((keynum - keynumA4)/12));
    xx = real( X*exp(j*2*pi*freq*t) );
    envelope = ADSREnvelope(t, attack_time, decay_time, sustain_level, release_time);
    xx = xx .* envelope;

end

function envelope = ADSREnvelope(t, attack_time, decay_time, sustain_level, release_time)
    envelope = zeros(size(t));
    
    % Attack phase
    attack_indices = t <= attack_time;
    envelope(attack_indices) = linspace(0, 1, sum(attack_indices));
    
    % Decay phase
    decay_indices = t > attack_time & t <= (attack_time + decay_time);
    envelope(decay_indices) = linspace(1, sustain_level, sum(decay_indices));
    
    % Sustain phase
    sustain_indices = t > (attack_time + decay_time) & t <= (1 - release_time);
    envelope(sustain_indices) = sustain_level;
    
    % Release phase
    release_indices = t > (1 - release_time);
    envelope(release_indices) = linspace(sustain_level, 0, sum(release_indices));
end