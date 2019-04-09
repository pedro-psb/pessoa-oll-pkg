\version "2.19.82"

\include "custom-include/pitch-names/solfa-note-name.ily"

scale=\relative do'{
  do re mi fa sol la ti do re mi r2
}
\new Staff {
  <<
    \scale
    \context NoteNames {
      \set printOctaveNames = ##f
      \scale
    }
  >>
  <<
    \key la \major
    \transpose do la \scale
    \context NoteNames {
      \set printOctaveNames = ##t
      \scale
    }
  >>
}