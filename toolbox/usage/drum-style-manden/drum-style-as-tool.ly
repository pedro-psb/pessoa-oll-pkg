\version "2.19.83"
% Use loadTools to load drum-styles
% setup pseudo MWE.
% develop necessary function to make it work.

%%%%%%%%%%%%%%%%%%
%%% pseudo MWE %%%
%%%%%%%%%%%%%%%%%%
\include "oll-core/package.ily"
\loadModule pessoa-oll-pkg.toolbox
% #(display fooString) % OK. loadModule loads 'string variable'
{}
\fooFunction
% \include "pessoa-oll-pkg/toolbox/module.ily"
% \loadModule oll-core.load.tools
% \loadDrumStyle "foo"

%{ OPT 1
\loadModule \with {
  drum-staff-style = manden
} pessoa-oll-pkg.toolbox.drum-styles
%}
%{ OPT 2
\loadTool drum-styles.manden
%}

% #(display drum-mods)
drum-mods = \with {
  \override StaffSymbol.line-count =  #3
  instrumentName = #"Dunduns"
  % drumStyleTable = #(alist->hash-table djembe)
  % drumPitchTable = #(alist->hash-table midiDrumPitches)
}
%{
dun = \drummode {
  sgo16 16 sgm16 16 sgb4
  kko16 16 kkm16 16 kkb4
  dno16 16 dnm16 16 dnb4
}
%}
dun = \drummode {
  sn16 16 16 16
  bd16 16 16 16
  toml16 16 16 16
}
\score {
  \new DrumStaff
  \with {
    \drum-mods
  }
  \dun
  \layout {}
  \midi {}
}
%%%%%%%%%%%%%%%%%%%%%%
%%% implementation %%%
%%%%%%%%%%%%%%%%%%%%%%
%{
#(define-public getStyleOpt
   (define-scheme-function (style) (list?)
     "Convenient way to get style from the root style folder"
     (getOption `(,@drum-style-root ,@style))))

setMods = 
#(define-scheme-function (opts)(list?)
   "What does it do? Where does it live?"
   (let ((drum-style (ly:assoc-get 'style opts))
         (midi-drum-pitc (ly:assoc-get 'style opts)))
     #{
       \with {
         drumStyleTable = #(alist->hash-table staff-config)
         drumPitchTable = #(alist->hash-table midi-drum-pitc)
       }
     #}))

% drumMods = \setMods \getStyleOpt manden-default
%}



%%%%%%%%%%%%
%%% misc %%%
%%%%%%%%%%%%

% \initStyle manden-default
%{ DEPRECATED 
   #(define-public initStyle
     (define-scheme-function (style-symbol)(symbol?)
       (let ((drum-style (ly:parser-lookup style-symbol)))
         (for-each
          (lambda (k)
            (let ((v (ly:assoc-get k style #f #f)))
              (if (not (defined? k)) (ly:parser-define! k v))))
          (map (lambda (x) (car x)) style)))))

%}