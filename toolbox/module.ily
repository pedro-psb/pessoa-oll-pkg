\version "2.19.82"
%%%%%%%%%%%%%%%%%%%%%%
%%% toolbox module %%%
%%%%%%%%%%%%%%%%%%%%%%
% definitions
% TODO make custom loadTool DrumStyle
% #(loadMessage)

% \loadModule oll-core.load.tools
% \include "oll-core/load/tools.ily"
% loadDrumStyle = #(define-void-function (x)(scheme?) (display "styleee"))

\include "oll-core/package.ily"

fooString = "foo string\n"
fooFunction =
#(define-void-function ()()
   (display "foo function\n"))


%{
loadDrumStyle =
#(define-void-function (x)(scheme?)
   #{
     \setOption oll-core.load.tools.directory
     #(os-path-join (append openlilylib-root '(pessoa-oll-pkg toolbox drum-styles)))
     \loadTool foo
   #})
loadNoteName =
#(define-void-function (x)(scheme?)
   #{
     \setOption oll-core.load.tools.directory
     #(os-path-join (append openlilylib-root '(pessoa-oll-pkg toolbox note-names)))
     \loadTool foo
   #})
%}











%{ What is this for?
def.foo = 23
def.bar = 96
def.rab = 5
def.oof = 73

#(define-public initStyle
   (define-scheme-function (style-symbol)(symbol?)
     (let ((style (ly:parser-lookup style-symbol)))
       (for-each
        (lambda (k)
          (let ((v (ly:assoc-get k style #f #f)))
            (if (not (defined? k)) (ly:parser-define! k v))))
        (map (lambda (x) (car x)) style)))))

\initStyle def
#(display rab)
%}