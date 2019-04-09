\version "2.19.82"
\include "oll-core/package.ily"
\loadPackage lalily-templates

node = pedros.master.piece

\setMusicFolder \node
\setTitle "A collection"

mus = \relative c'' { \repeat unfold 4 { g8 e4 g8 a8 g4 e8 g8 e4 c8 d4 e f g,} }

\setMusicFolder \node.pieceA
\setTitle "Piece A" % for demo
\putMusic meta { \key c \major s1*5 \bar "||" \mark \default s1*5 \bar "|." }
\putMusic \mus

\setMusicFolder \node.pieceB
\setTitle "Piece B"
\putMusic meta { \key es \major #(skip-of-length mus) \bar "|." }
\putMusic \mus

\setMusicFolder \node.pieceC
\setTitle "Piece C"
\putMusic meta { \key e \major #(skip-of-length mus) \bar "|." }
\putMusic \mus

setChildrenTemplates =
#(define-scheme-function (base template) (list? list?)
   "Set a $template for all children of a $base path.
Eg: 'book.movement' has children 'partI' 'partII' 'partIII'.
> setChildrenTemplates book.movement lalily.instrument.generic
will apply the lalily template to all those parts."
   (for-each
    (lambda (k)
      #{
        \setMusicFolder #`(,@base ,k)
        \setTemplate #template
      #})
    (get-music-keys base)))

\setChildrenTemplates \node lalily.instrument.generic
\setMusicFolder \node
\lalilyBookpart #'()

