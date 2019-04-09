\version "2.19.82"

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%	Log-Messages	%%%

% Convenience display function with (MSG VAR)
#(define-public (p-display msg var) (ly:message "[~a]\n -- ~a\n" msg var))

% Full path to current file
#(define-public thisFile
   (define-scheme-function (parser location) () (car (ly:input-file-line-char-column location))))

% Filter path reltaive to local
#(define-public (path-from-local)
   (let ((p (member "pessoa-pkg" (os-path-split (thisFile)))))
     (os-path-join-os p)))

% Default load massage to check when included properly.
% TODO register an option in to \includePattern to mimic this, so there is no need to put loadMessage on all files.
#(define-public (loadMessage)
   (if loadMessageOn (p-display "pessoa-pkg" (path-from-local))))

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%	   Misc		%%%

#(define (symbol->pitch x)
   "Symbol to Pitch"
   (if (symbol? x)
       (let ((y (ly:parse-string-expression (ly:parser-clone) (symbol->string x))))
         (if (ly:pitch? y) y
             (p-display ">> WANING ~A symbol is not a pitch" x)))
       (p-display ">> WANING ~A not symbol" x)))

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%	Not in use?	%%%

#(define-public (oll-root-relative p)
   "get the root folder of oll. Util to acess the local folder."
   "NOTE: Not in use anymore, but may be useful for something?"
   (os-path-join-os
    (append openlilylib-root (os-path-split-os p))))