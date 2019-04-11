\version "2.19.82"
%%%%%%%%%%%%%%%%%%%%%%
%%% toolbox module %%%
%%%%%%%%%%%%%%%%%%%%%%
% It
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


