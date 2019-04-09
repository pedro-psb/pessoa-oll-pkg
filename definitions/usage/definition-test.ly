\version "2.19.82"
\include "oll-core/package.ily"
\loadModule local.definitions.note-names.manden
\loadModule local.definitions.drum-styles.manden

drumNames = \getStyleOpt manden-default.melodia
#(display-scheme-music drumNames)
global = {
  \key c \major
  \time 4/4
}

drum = \drummode {
  \global
  sgo8 8 8 8
  dno16 16 16 16
  kko8 16 16
  sn4
}

\score {
  \new DrumStaff \with {
    % \drum-mods
    \consists "Instrument_name_engraver"
    instrumentName = "Drums"
  } \drum
  \layout { }
  \midi {
    \tempo 4=100
  }
}
