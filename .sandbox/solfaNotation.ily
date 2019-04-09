\version "2.19.82"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Auto Solfa Notation
% Anders Eriksson:
% - 2016: syllabes mapping
% Pedro Pessoa:
% - 2018: process octave ticks when "printOctaveNames" is true
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Enter the notes in a var.
%%% Create Rhythmic Staff with NoteName context overrides.

#(use-modules (ice-9 regex))
solfege-names = 
#`( 
    ("c" . "d") 
    ("d" . "r") 
    ("e" . "m") 
    ("f" . "f") 
    ("g" . "s") 
    ("a" . "l") 
    ("b" . "t") 

    ("ces" . "des") 
    ("des" . "res") 
    ("ees" . "mes") 
    ("fes" . "fes") 
    ("ges" . "sa") 
    ("aes" . "lo") 
    ("bes" . "ta") 

    ("cis" . "dis") 
    ("dis" . "ris") 
    ("eis" . "mis") 
    ("fis" . "fis") 
    ("gis" . "si") 
    ("ais" . "li") 
    ("bis" . "tis") 
    ) 

solfegeFixedNames = 
#(lambda (grob)
   "Remaps the NoteName to custom syllabes. Keeps octave data"
   (let*
    ((default-name (ly:grob-property grob 'text))
     ;;; Get the the note-name and the octave ticks in a list
     ;;; Use just the note-name to remmap the note-names
     ;;; Join the octave to the remmaped note-named.
     (splited (map match:substring (list-matches "[a-z]+|'+|,+" default-name)))
     (split-name (car splited))
     (split-octave (cdr splited))
     (new-name (if (pair? split-octave)
                   (string-append
                    (assoc-get split-name solfege-names)
                    (car split-octave))
                   (assoc-get split-name solfege-names))))
    ;; set the new names
    (ly:grob-set-property! grob 'text new-name)
    (ly:text-interface::print grob)
    ) 
   )