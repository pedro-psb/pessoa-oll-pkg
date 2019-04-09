\version "2.19.65"
\include "oll-core/package.ily"
\include "local/lalily-template-user/templates/manden.ily"
\loadPackage lalily-templates
%% Set the template options and register in the Template Tree.

opts = #'() 
opts."_order" = A.B 
opts.A."_template" = lalily.instrument.trumpet
opts.B."_template" = lalily.instrument.trombone
\setDefaultTemplate mymusic.piece.42 group #opts
\setTitle "Hello World"
\header {
  subtitle = "foo"
}
%% Input music and register it in the Music Tree.
meta={ \time 4/4 \key f \major s1*2 \bar "|." }
mus=\relative { c'4 bes a g | f1}

\putMusic meta \meta
\putMusic A \relative { \mus }
\putMusic B \relative { \transpose f cis' \mus }

\setMusicFolder mymusic.piece.41
\putMusic meta \meta
\putMusic A \relative { s1*4 \transpose f f' \mus }
\putMusic B \relative { s1*4 \transpose f cis'' \mus }


%\changeMusicFolder B
{
  \setMusicFolder mymusic.piece.42
  <<
    \getMusic A
    \getMusic B
  >>
}
{
  \changeMusicFolder LY_UP.41
  % IS EQUAL TO: \setMusicFolder mymusic.piece.42
  <<
    \getMusic A
    \getMusic B
  >>
}
%% Create the score
%\lalilyCreate

%% Obs:

% #(display (format-alist opts)) % Helper function to examnie opts.
% The current folder is mymusic/piece/42, so \putMusic meta {} stores at mymusic/piece/42/meta. Likewise, \getMusic meta retrieves mymusic/piece/42/meta.

% typeset the music with \lalilyCreate -- but only if this file is compiled directly
% if you include this file all music is stored, but is not typeset and can be used elsewhere