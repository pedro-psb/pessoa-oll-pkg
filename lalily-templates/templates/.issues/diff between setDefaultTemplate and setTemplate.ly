\version "2.19.82"
\include "oll-core/package.ily"
\loadPackage lalily-templates
%%% ISSUE
% Using (setMusicFolder + setTemplate) is not equivalent to (setDefaultTemplate)
% The second doesn't show the correct title in this case.

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

%{ SHOW TITLES
\setMusicFolder \node.pieceA
\setTemplate lalily.instrument.generic
\setMusicFolder \node.pieceB
\setTemplate lalily.instrument.generic
\setMusicFolder \node.pieceC
\setTemplate lalily.instrument.generic
%}

%{ DOESN'T SHOW TITLES
\setDefaultTemplate \node.pieceA lalily.instrument.generic #'()
\setDefaultTemplate \node.pieceB lalily.instrument.generic #'()
\setDefaultTemplate \node.pieceC lalily.instrument.generic #'()
%}

\setMusicFolder \node
\lalilyBookpart #'()

