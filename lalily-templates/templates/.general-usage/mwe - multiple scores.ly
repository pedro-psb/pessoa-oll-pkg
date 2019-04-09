\version "2.19.82"
\include "oll-core/package.ily"
\loadPackage lalily-templates
% MWE to generate multiple small scores with lalily-template.
% Issues:
% -- Manual solution found with \createScore, but can't automate/iterate it. I guess it envolves some parser matters which I don't understand.
% -- In the first place, it would be better to use existing lalily-structures to do this, rather than create an external "patchwork" solution. In another words, add scores do the mix with exiting tools (I figure they may exist in the package) and invoke one lalilyCreate to create them all.

node = pedros.master.piece

\setMusicFolder \node
\setTitle "A collection"

mus = \relative c'' { \repeat unfold 4 { g8 e4 g8 a8 g4 e8 g8 e4 c8 d4 e f g,} }

% If you first set the music folder to the piece to fill, the following commands refer to that
\setMusicFolder \node.pieceA
\setTitle "Piece A" % for demo
% avoid annoying "no template defined" messages ...
\setTemplate lalily.instrument.trumpet % ... and demo: trumpet is in B flat
% keeping all global information in the "global" track
\putMusic meta { \key c \major s1*5 \bar "||" \mark \default s1*5 \bar "|." }
\putMusic \mus

\setMusicFolder \node.pieceB
\setTitle "Piece B"
\setTemplate lalily.instrument.generic
\putMusic meta { \key es \major #(skip-of-length mus) \bar "|." }
\putMusic \mus

% collect some options for the template
% TODO: there has to be a reference about all template options!
opts.instrument-name = "Pipe"
opts.staff-mods = \with { \override NoteHead.color = #blue }
% shortcut for setMusicFolder, setTemplate and setScoreOption
\setDefaultTemplate \node.pieceC lalily.instrument.generic #opts
\setTitle "Piece C"
\putMusic meta { \key e \major #(skip-of-length mus) \bar "|." }
\putMusic \mus

% reset the music folder to our base path
\setMusicFolder \node

% a key PAGE-BREAK! forces a page break
% opts.keys = pieceA,pieceB,"PAGE-BREAK!",pieceC
\lalilyBookpart #opts

