\version "2.19.82"
\include "oll-core/package.ily"
\loadModule oll-core.util.include-pattern
\setOption oll-core.include-pattern.log-includes ##t

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%      TODO 		%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% loadUserPackage: Use path helper functions of OLL to deal with paths in more clean way.

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%     Path Register	%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Include all files inside the path

%%% Lalily %%%
paths.lalily-manden = "lalily-templates/templates/manden"
paths.lalily-ex-book = "lalily-templates/templates/exercise-book"

%%% General %%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%        Main		%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
#(define-public (oll-root-relative p)
   "get the root folder of oll. Util to acess the local folder."
   "NOTE: Not in use anymore, but may be useful for something?"
   (os-path-join-os
    (append openlilylib-root (os-path-split-os p))
    ))

loadUserPackage=
#(define-music-function(package)(symbol?)
   "Gets path from paths Alist and load all files inside it"
   (let* ((p (assoc-get package paths))
          (p-local (string-append (oll-root-relative "local/") p)))
     #{\includePattern $p-local ".*\.ily" #}))


%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%        Misc		%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
loadLog=
#(define-scheme-function ()()
   "Log msg to include in files."
   (let ((this-p (this-file)))
     (display (format "\nLoaded: '~A'\n"
                (os-path-join-os (reverse (list-head (reverse this-p) 4)))))))