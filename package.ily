\version "2.19.82"
%%%%%%%%%%%%%%%%%%%%%%
%%% pessoa-oll-pkg %%%
%%%%%%%%%%%%%%%%%%%%%%
\include "oll-core/package.ily"

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  Current solution	%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%{
registerDefaultOpt = 
#(define-void-function(path default) (list? scheme?)
   "Only register option if it isn't already registered"
   (if (not (option-registered? path))
       (registerOption path default)))

\registerDefaultOpt pessoa-oll-pkg.loadMessage ##f
\registerDefaultOpt pessoa-oll-pkg.foo "loaded from package.ily"
%} %END

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  Ideal solution	%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
\registerOption pessoa-oll-pkg.loadMessage ##t
\registerOption pessoa-oll-pkg.foo "loaded from package.ily"
%} %END


%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  	   Body		%%%

%% Testing Options Precedence
% #(ly:message "\n\n*** ~a ***\n\n" (getOption '(pessoa-oll-pkg foo)))

loadMessageOn = \getOption pessoa-oll-pkg.loadMessage
\include "pessoa-oll-pkg/internal/common.ily"
#(loadMessage)