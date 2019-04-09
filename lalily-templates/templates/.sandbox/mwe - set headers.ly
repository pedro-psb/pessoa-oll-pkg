\version "2.19.82"
\include "oll-core/package.ily"
\loadPackage lalily-templates

node = pedros.master.piece

\setMusicFolder \node
\setTitle "A collection"

mus = \relative c'' { \repeat unfold 4 { g8 e4 g8 a8 g4 e8 g8 e4 c8 d4 e f g,} }

\setMusicFolder \node.pieceA
\setTitle "Piece A" % for demo
\putMusic meta { \key c \major s1*5 \bar "||" \mark \default s1*5 \bar "|." }
\putMusic \mus

\setMusicFolder \node.pieceB
\setTitle "Piece B"
\putMusic meta { \key es \major #(skip-of-length mus) \bar "|." }
\putMusic \mus

\setMusicFolder \node.pieceC
\setTitle "Piece C"
\putMusic meta { \key e \major #(skip-of-length mus) \bar "|." }
\putMusic \mus


\setMusicFolder \node.pieceA
\setTemplate lalily.instrument.generic
\setHeader #'() title ##f

\setMusicFolder \node.pieceB
\setTemplate lalily.instrument.generic
\setHeader #'() title "fooo2"

\setMusicFolder \node.pieceC
\setTemplate lalily.instrument.generic
\setHeader #'() title "fooo3"

\setMusicFolder \node
\lalilyBookpart #'()

