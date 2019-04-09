\version "2.19.82"
\include "oll-core/package.ily"
\loadPackage lalily-templates

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%        Todo		%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure why Frescobaldi is throwing midi error all the time.
% [x] Init function. Define if it isn't bound.

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%      Templates	%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
\registerTemplate exercise-book.default
#(define-music-function (mus opts)(list? list?)
   "Exercise creator"
   (let ((curNum (number->string (last (get-current-music))))
         (template (get-option '_template opts "lalily.instrument.generic")))
     #{
       \new Staff \with {
         instrumentName = \markup \number \huge \bold #curNum
       }{
         \getMusic #'()
         \bar "|."
       }
     #}))

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%       Functions	%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Numbering %%%

#(define init-numbering-bool #f)
#(define-public (init-numbering)
   (if (not (defined? 'numbering))
       (ly:parser-define! 'numbering 0))
   (if (not (defined? 'currentNumbering))
       (ly:parser-define! 'currentNumbering '()))
   (set! init-numbering-bool #t))

#(define-public (add-numbering)
   (if (not init-numbering-bool) (init-numbering)) ; init once
   (set! numbering (+ numbering 1))
   (set! currentNumbering (list numbering))
   )

#(define-public putNumMusic
   (define-music-function (music)(ly:music?)
     (add-numbering)
     (let ((p (create-music-path #f currentNumbering)))
       (put-music p music)
       (make-music 'SimultaneousMusic 'void #t))))

%%% Util %%%

#(define-public setChildrenTemplates
   (define-scheme-function (base template) (list? list?)
     "Set a $template for all children of a $base path.
Eg: 'book.movement' has children 'partI' 'partII' 'partIII'.
> setChildrenTemplates book.movement lalily.instrument.generic
will apply the generic template to all those parts."
     (for-each
      (lambda (k)
        #{
          \setMusicFolder #`(,@base ,k)
          \setTemplate #template
          % TODO only set to false if the title is unset. (don't override rule).
          \setHeader #'() title ##f
          \setLayout \layout {
            \context {
              \Score
              \override BarNumber.stencil = ##f
            }
          }
        #}) (get-music-keys base))))

#(define-public setDefaultPaper
   (define-scheme-function (base) (list?)
     "Throws ERRORS. Set default paper and layout definitions. Needs more thought"
     #{
       \setMusicFolder #base
       \setPaper \paper {
         indent = 8\mm
         line-width = 6\in
         ragged-right = ##f
       }
     #}))
