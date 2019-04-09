# Paths
(get-music path) -> absolute, need full path
(getMusic path) -> relative to current folder
// Talvez se aplique a call-template vs callTemplate,etc.



# Printing

% #(format #t "~A\n" music-tree)	
% #(format #t "~A\n" (get-music-keys '()))

% #(display-music-pieces)
% #(display-templates)

% #(display (get-current-music))
% #(display (getCurrentMusic))

% #(display (get-current-template))
% #(display (getTemplate))

% #(display (get-music-folder-options))
% #(display (getScoreOptions))

% #(get-current-template)
% #(display-default-music)
% #(display (musicPath '(foo)))
