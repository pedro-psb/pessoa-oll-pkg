\version "2.19.82"
\include "oll-core/package.ily"

%%{ Current solution
\registerOption pessoa-pkg.loadMessage ##f
\registerOption pessoa-pkg.foo "loaded from the source .ly"
\loadModule pessoa-pkg.foo-module
\loadModule pessoa-pkg.foo-module.foo-a-submodule

% \displayModuleOptions pessoa-pkg
%}

% \loadPackage \with { foo = "loaded from the source .ly" } local
