Illustrate hsc2hs+cabal bug
===========================

Problem
-------

If you remove `Foo.hsc` and create a new `Foo.hs`, cabal continues to
use the old `Foo.hs` which it generated from the deleted `Foo.hsc`
file. To make cabal use the new `Foo.hs`, you have to delete the old,
cached `Foo.hs` from `dist/*/build`.

Cabal and GHC versions
----------------------

    $ cabal --version
    cabal-install version 1.22.6.0
    using version 1.22.2.0 of the Cabal library

    $ ghc --version
    The Glorious Glasgow Haskell Compilation System, version 7.10.2

Setup
-----

    $ rm -rf .cabal-sandbox
    $ cabal sandbox init

Source files
------------

`bug/Main.hs`:
```haskell
module Main where

import Foo

main = print foo
```

`bug/Foo.hsc`:
```haskell
module Foo where

foo = "Using the old .hsc file!"
```

`new-foo/Foo.hs`
```haskell
module Foo where

foo = "Using the new .hs file!"
```

`cabal-hsc2hs-bug.cabal`:
```
name:                cabal-hsc2hs-bug
version:             0.1.0.0
license:             BSD3
license-file:        LICENSE
author:              Nathan Collins
maintainer:          nathan.collins@gmail.com
build-type:          Simple
cabal-version:       >=1.10

executable bug
  main-is:             Main.hs
  other-modules:       Foo
  hs-source-dirs:      bug
  build-depends:       base
  default-language:    Haskell2010
```

Observed, buggy behavior
------------------------

```console
$ cabal install && .cabal-sandbox/bin/bug
[...]
"Using the old .hsc file!"
$ rm bug/Foo.hsc
$ cp new-foo/Foo.hs bug/Foo.hs
$ cabal install && .cabal-sandbox/bin/bug
[...]
"Using the old .hsc file!"
$ find dist -name 'Foo.hs' -exec rm {} \;
$ cabal install && .cabal-sandbox/bin/bug
[...]
"Using the new .hs file!"
```