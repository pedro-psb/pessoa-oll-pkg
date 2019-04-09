%% Controlling of the pitch range in a score
%% http://lsr.di.unimi.it/LSR/Item?id=773
%% see also http://lilypond.org/doc/v2.18/Documentation/snippets/pitches

% by Gilles Thibault
% Y/M/D = 2014/01/14

%{
Here is a set of 4 functions to check or modify the pitch range in a piece of music.
 \correctOctave
 \correctOctaveOutOfRange
 \colorizeOutOfRange
 \parenthesizeOutOfRange
Here is the code of each Staff :
    \music                               % staff 1
    \correctOctave #'above g'' \music    % staff 2
    \correctOctave #'below g' \music     % staff 3
    \correctOctaveOutOfRange g' g'' \music % staff 4
    \colorizeOutOfRange g' g'' \music    % staff 5
    \parenthesizeOutOfRange g' g'' \music    % staff 6
%}  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LSR workaround:
#(set! paper-alist (cons '("snippet" . (cons (* 140 mm) (* 140 mm))) paper-alist))
\paper {
  #(set-paper-size "snippet")
  tagline = ##f
}

\markup\vspace #.5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%here starts the snippet:

#(define (pitch>? p1 p2)
(ly:pitch<? p2 p1))

#(define (pitch-octavize p limit-pitch sym)
(let* ((above? (eq? sym 'above))
       (compare? (if above? pitch>? ly:pitch<?))
       (octavize (if above? 1- 1+)))     
  (let loop ((new-pitch p))
    (if (compare? new-pitch limit-pitch)
      (loop (ly:make-pitch (octavize (ly:pitch-octave new-pitch))
                           (ly:pitch-notename new-pitch)
                           (ly:pitch-alteration new-pitch)))
      new-pitch))))

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

correctOctave = #(define-music-function (parser location sym limit-pitch music)
                                            (symbol? ly:pitch? ly:music?)
"Corrects octave for notes in `music which are above `limit-note if 'above is
set for `sym, or which are below `limit-note if 'below is set."
(music-map
  (lambda (evt)
    (let ((p (ly:music-property evt 'pitch)))
      (if (ly:pitch? p)
        (ly:music-set-property! evt 'pitch
          (pitch-octavize p limit-pitch sym)))
      evt))
   music))

  
correctOctaveOutOfRange = #(define-music-function 
       (parser location low-pitch high-pitch music)(ly:pitch? ly:pitch? ly:music?)
"Corrects octave of notes not in range `low-note `high-note"
#{ 
  \correctOctave #'below $low-pitch
      \correctOctave #'above $high-pitch $music
#})                                             

%% general implementation for a custum function (func)
%% func must have one music argument, and return a music.
customOutOfRange = #(define-music-function (parser location low-pitch high-pitch func music)
                      (ly:pitch? ly:pitch? ly:music-function? ly:music?)
"Apply func to notes, out of range `low-note `high-note"                      
 (if (ly:pitch<? low-pitch high-pitch)
    (music-map
      (lambda (evt)
        (let ((p (ly:music-property evt 'pitch)))
          (if (and (ly:pitch? p)
                   (or (ly:pitch<? p low-pitch)
                       (ly:pitch<? high-pitch p)))
            #{ $func $evt #}
            evt)))
      music)
    music))

%% apply \customOutOfRange to \parenthesize
parenthesizeOutOfRange = #(define-music-function (parser location low-pitch high-pitch music)
                            (ly:pitch? ly:pitch? ly:music?)
"Parenthesize notes out of range `low-note `high-note" 
  #{ \customOutOfRange $low-pitch $high-pitch #parenthesize $music #})


colorizeOutOfRange = #(define-music-function (parser location low-pitch high-pitch music)
                         (ly:pitch? ly:pitch? ly:music?)
"Colorize in red, notes out of range `low-note `high-note"
(let ((colorfunc 
        (define-music-function (parser location evt)(ly:music?)
          #{ \tweak color #red $evt #})))
  #{ \customOutOfRange $low-pitch $high-pitch #colorfunc $music #}))

% a scheme function : music and range as music
% range in the form of : <c g'> or { c g' }
#(define (correct-out-of-range music range)
(let ((low #f)
      (high #f))
(music-map                  ; first pitch -> low, second pitch -> high
  (lambda (evt)
     (let ((p (ly:music-property evt 'pitch)))
        (if (ly:pitch? p) (cond
           ((not low)(set! low p))
           ((not high)(set! high p))))
        evt))
  range)
(music-map
   (lambda (evt)
     (let ((p (ly:music-property evt 'pitch)))
        (if (ly:pitch? p)
          (ly:music-set-property! evt 'pitch
            (pitch-octavize (pitch-octavize p low 'below) high 'above)))
        evt))
    (ly:music-deep-copy music))))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% tests

music = \relative c' {
  c4 d e f 
  g^"g'" a b c
  d e f g^"g''" a b c2
}


\score {<<
  \new Staff \with { instrumentName = "1"} 
        \music                               % staff 1
  \new Staff \with { instrumentName = "2"} 
        \correctOctave #'above g'' \music    % staff 2    
  \new Staff \with { instrumentName = "3"} 
        \correctOctave #'below g' \music     % staff 3     
  \new Staff \with { instrumentName = "4"} 
        \correctOctaveOutOfRange g' g'' \music % staff 4
  \new Staff \with { instrumentName = "5"} 
        \colorizeOutOfRange g' g'' \music    % staff 5 
  \new Staff \with { instrumentName = "6"} 
        \parenthesizeOutOfRange g' g'' \music    % staff 6 
>>
}
%{ %%uncomment for testing correct-out-of-range
range = < g' g'' >
#(define musicII (correct-out-of-range music range))

\new Staff \with { instrumentName = "6"} 
        \musicII   % staff 6 
%}