\version "2.19.65"

musicA=\drummode{
  sn8 8 8 8 8 8 8 8
}
musicB=\drummode{
  bd8 8 toml8 8 8 bd8 8 8
}
verseA = \lyricmode {
  tam -- ta -- ri -- ki
}
verseB = \lyricmode {
  tam -- ta -- ri -- ki
}

#(define my-style
   '((snare  default   #f   3) 
     (tomlow  default   #f   0)
     (bassdrum  default   #f   -3)))

\score {
  <<
  \new DrumStaff = "dr" \with { }
  <<
    \set DrumStaff.drumStyleTable = #(alist->hash-table my-style)
    \override Staff.StaffSymbol.line-positions = #'(-3 0 3)
    \new DrumVoice = "drumsA" { \voiceOne \musicA }
    \new DrumVoice = "drumsB" { \voiceTwo \musicB }
  >>
  \new Lyrics \with {
    alignAboveContext = "dr"
    \override VerticalAxisGroup #'staff-affinity = #CENTER
  } \lyricsto "drumsA" \verseA
    \new Lyrics \with {
    \override VerticalAxisGroup #'staff-affinity = #CENTER
  } \lyricsto "drumsB" \verseB
  >>
  \layout {}
  \midi {}
}
