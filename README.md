Illustrate hsc2hs+cabal bug
===========================

Problem
-------

The `HSC.hsc` file does not get reprocessed when the CPP definitions
change, only when the `HSC.hsc` file itself is changed. On the other
hand, the regular Haskell `HS.hs` file does get reprocessed when the CPP
definitions change.

Cabal and GHC versions
----------------------

    $ cabal --version
    cabal-install version 1.22.6.0
    using version 1.22.2.0 of the Cabal library

    $ ghc --version
    The Glorious Glasgow Haskell Compilation System, version 7.10.2

Setup
-----

    $ cabal sandbox init

Source files
------------

    $ cat bug/Main.hs
    module Main where

    import HS
    import HSC

    main = do
      putStrLn $ "hsTest  = " ++ show hsTest
      putStrLn $ "hscTest = " ++ show hscTest

    $ cat src/HS.hs
    {-# LANGUAGE CPP #-}
    module HS where

    hsTest :: Bool
    #ifdef CPP_FLAG
    hsTest = True
    #else
    hsTest = False
    #endif

    $ cat src/HSC.hsc
    {-# LANGUAGE CPP #-}
    module HSC where

    hscTest :: Bool
    #ifdef CPP_FLAG
    hscTest = True
    #else
    hscTest = False
    #endif

    $ cat cabal-hsc2hs-bug.cabal
    name:                cabal-hsc2hs-bug
    version:             0.1.0.0
    license:             BSD3
    license-file:        LICENSE
    author:              Nathan Collins
    maintainer:          nathan.collins@gmail.com
    build-type:          Simple
    cabal-version:       >=1.10

    flag cabal_flag
      description:         a Cabal flag
      default:             True
      manual:              True

    library
      exposed-modules:     HS, HSC
      other-extensions:    CPP
      build-depends:       base
      hs-source-dirs:      src
      build-tools:         hsc2hs
      default-language:    Haskell2010

      if flag(cabal_flag)
        cpp-options:         -DCPP_FLAG
        cc-options:          -DCPP_FLAG

    executable bug
      main-is:             Main.hs
      hs-source-dirs:      bug
      build-depends:       base, cabal-hsc2hs-bug
      default-language:    Haskell2010

Observed, buggy behavior
------------------------

    $ for prefix in "+" "-"; do \
        cabal configure --flags="${prefix}cabal_flag" && \
        cabal build -j1 && \
        cabal copy \
        && .cabal-sandbox/bin/bug; \
      done
    [...]
    hsTest  = True
    hscTest = True
    [...]
    hsTest  = False
    hscTest = True

Notice that `hscTest` is always `True`. If you instead configure with
the flag disabled the first time, then `hscTest` is always `False`.

Expected behavior
-----------------

By touching the `HSC.hsc` file first, we can force a regeneration of
the `HSC.hs` file:

    $ for prefix in "+" "-"; do \
        touch src/HSC.hsc && \
        cabal configure --flags="${prefix}cabal_flag" && \
        cabal build -j1 && \
        cabal copy \
        && .cabal-sandbox/bin/bug; \
      done
    [...]
    hsTest  = True
    hscTest = True
    [...]
    hsTest  = False
    hscTest = False

See file `FULL_OUTPUT.md` if interested in full output.
