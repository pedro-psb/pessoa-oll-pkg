\version "2.19.82"
\include "oll-core/package.ily"
\loadModule pessoa-oll-pkg.toolbox.note-names.manden
\loadModule pessoa-oll-pkg.toolbox.drum-styles.manden

%{
drumNames = \getStyleOpt manden-default.melodia
#(display-scheme-music drumNames)
%}

global = {
  \key c \major
  \time 4/4
}

drumMusic = \drummode {
  \global
  sgo8 8 8 8
  dno16 16 16 16
  kko8 16 16
  sn4
}

\score {
  \new DrumStaff \with {
    \drum-mods
    \consists "Instrument_name_engraver"
    instrumentName = "Drums"
  } \drumMusic
  \layout { }
  \midi {
    \tempo 4=100
  }
}
