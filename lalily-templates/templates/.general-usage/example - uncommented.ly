\version "2.19.80"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
% This file is part of openLilyLib,                                           %
%                      ===========                                            %
% the community library project for GNU LilyPond                              %
% (https://github.com/openlilylib)                                            %
%              -----------                                                    %
%                                                                             %
% Library: lalily-templates                                                   %
%          ================                                                   %
%                                                                             %
% openLilyLib is free software: you can redistribute it and/or modify         %
% it under the terms of the GNU General Public License as published by        %
% the Free Software Foundation, either version 3 of the License, or           %
% (at your option) any later version.                                         %
%                                                                             %
% openLilyLib is distributed in the hope that it will be useful,              %
% but WITHOUT ANY WARRANTY; without even the implied warranty of              %
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the               %
% GNU General Public License for more details.                                %
%                                                                             %
% You should have received a copy of the GNU General Public License           %
% along with openLilyLib. If not, see <http://www.gnu.org/licenses/>.         %
%                                                                             %
% openLilyLib is maintained by Urs Liska, ul@openlilylib.org                  %
% lalily-templates is maintained by Jan-Peter Voigt, jp.voigt@gmx.de          %
% and others.                                                                 %
%       Copyright Jan-Peter Voigt, Urs Liska, 2017                            %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% TODO clean up for a short example, extra feature showcase in another file!

\include "oll-core/package.ily"
\loadPackage lalily-templates

\consistToContexts #edition-engraver Score.Staff.Voice

\setEditions sheet

% options for full score
\optionsInit opts
% these settings are for demonstration (and testing)
\optionsAddL opts "_template" group

% two trumpets in B flat (default, other transpositions possible with property 'transposition)
\optionsAdd opts trumpet.III.transposition #(ly:make-pitch 0 3) % transposition F
\optionsAdd opts trumpet.III.output-concert-pitch ##f % the transposition of trumpet.III will only effective in the full score!

% a choir (SATB is default)
% TODO grouping will be rewritten like the global root. That is all meta data has a prefix '_', all other parts are assumed voices
\optionsAddL opts choir."_template" lalily.vocal.group
\optionsAddL opts choir.lyrics LY_UP.LY_UP.melody
\optionsAddL opts melody."_template" lalily.vocal
% another vocal part
\optionsAdd opts melody.vocname "melody"
% piano
\optionsAddL opts piano."_template" lalily.piano

%\callTemplate generic musik #'() % OK
%\createScore #'() % OK

% brass part
trumpet."_group" = #'GrandStaff
trumpet."_group-mods" = \with { \override NoteHead.color = #darkgreen }
trumpet.foo."_template" = lalily.instrument.trumpet
trumpet.II."_template" = lalily.instrument.trumpet
trumpet."_order" = foo.II.III
\setDefaultTemplate song.test.trumpet group #trumpet

\putMusic foo \relative { bes'4 a c b }
\putMusic II \relative { bes4 a c b }

\putMusic III \relative { bes4 a c b }
% relative change of current folder
\changeMusicFolder III
\setTemplate lalily.instrument.trombone % this is not transposed

%%% OK:
%\setDefaultTemplate song.test group #opts
%%% OK:
%\setTransposedTemplate bes c' song.test group #opts
\setMusicFolder song.test
\setScoreOptions #'() #opts
\setTitle "Hallo Welt"

% you can shorten long edition-context IDs with the current music path:
\editionMod sheet 1 0/4 \musicPath choir.sop.Voice { <>\p\< }
\editionMod sheet 1 4/4 \musicPath choir.sop.Voice { <>\! }
\editionMod sheet 1 1/4 \musicPath piano.right.Staff \once \override NoteHead.color = #red
\putMusic meta {
  \key f \major \time 4/4 s1 \bar "|."
}

\putMusic choir.sop \relative { bes'4 a c b }
\putMusic choir.alt \relative { bes4 a c b }
\putMusic choir.ten \relative { bes4 a c b }
\putMusic choir.bas \relative { bes,4 a c b }

\putMusic melody \relative { f''4 e g fis }
\putMusic melody.lyrics \lyricmode {
  la la la la
}

\putMusic piano.dynamics { s1\p\< <>\! }
\putMusic piano.right \relative { bes'4 a c b }
\putMusic piano.left \relative { bes,4 c d e }
\putMusic piano.pedal { s2.\sustainOn s4\sustainOff }

% if you include this file, the score will not be typeset unless you call \lalilyCreate or another creation function
% print full score
\lalilyTest
#(display #{ \opts.choir #})
#(newline)
%#(display (format-alist #{ \trumpet #}))
% print brass part
\setMusicFolder song.test.trumpet
\lalilyTest

