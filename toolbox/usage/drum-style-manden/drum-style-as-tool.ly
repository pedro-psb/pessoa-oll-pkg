\version "2.19.83"
% Use loadTools to load drum-styles
% setup pseudo MWE.
% develop necessary function to make it work.

%%%%%%%%%%%%%%%%%%
%%% pseudo MWE %%%
%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%
%%% implementation %%%
%%%%%%%%%%%%%%%%%%%%%%

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