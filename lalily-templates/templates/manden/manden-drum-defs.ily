\version "2.19.82"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% THIS SHOULD BE AVALIABLE GLOBALLY %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This file contains the following definitions for manden music:
% - drumPitchName 
% - midiDrumPitches 

#(define (symbol->pitch x)
   "Symbol to Pitch"
   (if (symbol? x)
       (let ((y (ly:parse-string-expression (ly:parser-clone) (symbol->string x))))
         (if (ly:pitch? y)
             y
             (ly:message ">> WANING ~A symbol is not a pitch" x)))
       (ly:message ">> WANING ~A not symbol" x)))


#(define-public (setDrumPitchName x y)
   (set! drumPitchNames (assoc-set! drumPitchNames x y)))

#(define-public (setMidiDrumPitch x y)
   (set! midiDrumPitches (assoc-set! midiDrumPitches x (symbol->pitch y))))

%%% Drum Names %%%
#(setDrumPitchName 'dng 'dnglock)
#(setDrumPitchName 'dnglock 'dnglock)
#(setDrumPitchName 'dnr 'dnrim)
#(setDrumPitchName 'dnrim 'dnrim)
#(setDrumPitchName 'dnm 'dnmute)
#(setDrumPitchName 'dnmute 'dnmute)
#(setDrumPitchName 'dno 'dnopen)
#(setDrumPitchName 'dnopen 'dnopen)

#(setDrumPitchName 'sgg 'sgglock)
#(setDrumPitchName 'sgglock 'sgglock)
#(setDrumPitchName 'sgr 'sgrim)
#(setDrumPitchName 'sgrim 'sgrim)
#(setDrumPitchName 'sgm 'sgmute)
#(setDrumPitchName 'sgmute 'sgmute)
#(setDrumPitchName 'sgo 'sgopen)
#(setDrumPitchName 'sgopen 'sgopen)

#(setDrumPitchName 'kkg 'kkglock)
#(setDrumPitchName 'kkglock 'kkglock)
#(setDrumPitchName 'kkr 'kkrim)
#(setDrumPitchName 'kkrim 'kkrim)
#(setDrumPitchName 'kkm 'kkmute)
#(setDrumPitchName 'kkmute 'kkmute)
#(setDrumPitchName 'kko 'kkopen)
#(setDrumPitchName 'kkopen 'kkopen)

#(setDrumPitchName 'djsm 'djslapmute)
#(setDrumPitchName 'djslapmute 'djslapmute)
#(setDrumPitchName 'djs 'djslap)
#(setDrumPitchName 'djslap 'djslap)
#(setDrumPitchName 'djom 'djopenmute)
#(setDrumPitchName 'djopenmute 'djopenmute)
#(setDrumPitchName 'djo 'djopen)
#(setDrumPitchName 'djbm 'djbassmute)
#(setDrumPitchName 'djbassmute 'djbassmute)
#(setDrumPitchName 'djb 'djbass)
#(setDrumPitchName 'djbass 'djbass)


%%% MidiPitches %%%
#(setMidiDrumPitch 'kkglock 'a'')
#(setMidiDrumPitch 'kkrim 'cis,)
#(setMidiDrumPitch 'kkmute 'fis,)
#(setMidiDrumPitch 'kkopen 'd)

#(setMidiDrumPitch 'sgglock 'f)
#(setMidiDrumPitch 'sgrim 'cis,)
#(setMidiDrumPitch 'sgmute 'fis,)
#(setMidiDrumPitch 'sgopen 'g,)

#(setMidiDrumPitch 'dnglock 'g')
#(setMidiDrumPitch 'dnrim 'cis,)
#(setMidiDrumPitch 'dnmute 'fis,)
#(setMidiDrumPitch 'dnopen 'b,,) % acousticbassdrum

#(setMidiDrumPitch 'djslapmute 'c') % hibongo
#(setMidiDrumPitch 'djslap 'c')
#(setMidiDrumPitch 'djopenmute 'cis')
#(setMidiDrumPitch 'djopen 'cis') % lobongo
#(setMidiDrumPitch 'djbassmute 'disis')
#(setMidiDrumPitch 'djbass 'disis') % openloconga
% #(pretty-print midiDrumPitches)
