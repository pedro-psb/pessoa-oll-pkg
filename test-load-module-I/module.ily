\version "2.19.82"
%%%%%%%%%%%%%%%%%%%%%%
%%% Foo Module  II %%%
%%%%%%%%%%%%%%%%%%%%%%
\include "oll-core/package.ily"

fooString = "foo string\n"
fooFunction =
#(define-void-function ()()
   (display "foo function\n"))

fooMusic = 
#(define-music-function ()()
   #{
     {e' e' e' e'}
   #})
