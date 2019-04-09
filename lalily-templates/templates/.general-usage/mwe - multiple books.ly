\version "2.19.82"
\include "oll-core/package.ily"
\loadPackage lalily-templates

base = composer.mass

opts."_order" = voice.bass
opts.voice."_template" = lalily.vocal
opts.voice.vocname = "Voice"
opts.bass."_template" = test.continuo
% there is a versatile continuo template in instrument.ily ... just a showcase
\registerTemplate test.continuo
#(make-template
  #{
    \new Staff \with { \clef bass } <<
      \getMusicDeep meta
      \getMusic #'() % music at current path (empty list)
      \getMusic {} general % default is empty music
    >>
  #})

\setDefaultTemplate \base.kyrie group #opts
\setDefaultTemplate \base.gloria group #opts
\setDefaultTemplate \base.credo group #opts
\setDefaultTemplate \base.sanctus group #opts
\setDefaultTemplate \base.agnusdei group #opts

\setMusicFolder \base
\putMusic kyrie.meta { s1 \bar "|." }
\putMusic kyrie.voice \relative { c''4 }
\putMusic kyrie.voice.lyrics \lyricmode { Ky }
\putMusic kyrie.bass \relative { c4 }
\putMusic kyrie.bass.general \figuremode { <5 3>4 }
\putMusic gloria.meta { s1 \bar "|." }
\putMusic gloria.voice \relative { c''4 }
\putMusic gloria.voice.lyrics \lyricmode { Glo }
\putMusic gloria.bass \relative { c4 }
\putMusic credo.meta { s1 \bar "|." }
\putMusic credo.voice \relative { c''4 }
\putMusic credo.voice.lyrics \lyricmode { Cre }
\putMusic credo.bass \relative { c4 }
\putMusic sanctus.meta { s1 \bar "|." }
\putMusic sanctus.voice \relative { c''4 }
\putMusic sanctus.voice.lyrics \lyricmode { Sa }
\putMusic sanctus.bass \relative { c4 }
\putMusic agnusdei.meta { s1 \bar "|." }
\putMusic agnusdei.voice \relative { c''4 }
\putMusic agnusdei.voice.lyrics \lyricmode { Ag }
\putMusic agnusdei.bass \relative { c4 }

% as you can see, the keys are not in alphabetic or addition order
% of course you can name the blocks A-part, B-part ...and then sort the list
#(ly:message "~A ~A" base (get-music-keys base))

% I have a command to create a bookpart with multiple scores in my personal toolbox ... it shall be added to this repo!

% short demo
#(for-each
  (lambda (k)
    #{
      \setMusicFolder #`(,@base ,k)
      \setTitle #(format "~A" k)
      \lalilyCreate
    #}) (get-music-keys base))
