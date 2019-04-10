\version "2.19.82"
\include "oll-core/package.ily"

%%{ -- Current solution --
\registerOption pessoa-oll-pkg.loadMessage ##f
\registerOption pessoa-oll-pkg.foo "loaded from the source .ly"
\loadPackage pessoa-oll-pkg
\loadModule pessoa-oll-pkg.foo-module
\loadModule pessoa-oll-pkg.foo-module.foo-a-submodule
%} %END


%{ -- Ideal solution --
\loadPackage \with {
  foo = "loaded from source.ly"
} pessoa-oll-pkg
%} %END


% \displayModuleOptions pessoa-oll-pkg