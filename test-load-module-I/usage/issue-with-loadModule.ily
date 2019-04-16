\version "2.19.83"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Issue with LoadModule %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% When using loadModule, a void function defined in the module.ily will load just if preceded by "something".

\include "oll-core/package.ily"

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% LOADING VOID FUNCTION %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{ WITH LOAD MODULE (strange behaviour)
% Just work if there is anything before. Uncomment any of the lines below:
\loadModule pessoa-oll-pkg.test-load-module-I
% {} 
% #(display "something")
% anything = "something"
\fooFunction
%}

%{ WITH INCLUDE (works)
\include "pessoa-oll-pkg/test-load-module-I/module.ily"
\fooFunction
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% LOADING MUSIC FUNCTION %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{ WITH LOAD MODULE (works)
\loadModule pessoa-oll-pkg.test-load-module-I
{ \fooMusic }
%}