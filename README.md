Illustrate hsc2hs+cabal bug
===========================

Problem: The .hsc file does not get reprocessed when the CPP
definitions change, only when the .hsc file itself is changed. On the
other hand, regular .hs files do get reprocessed when the CPP
definitions change.

Cabal and GHC versions:

    $ cabal --version
    cabal-install version 1.22.6.0
    using version 1.22.2.0 of the Cabal library

    $ ghc --version
    The Glorious Glasgow Haskell Compilation System, version 7.10.2

Setup:

    $ cabal sandbox init

Observed, buggy behavior:

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

If you instead configure with the flag disabled the first time, then
`hscTest` is always `False`.

Expected behavior:

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

See file FULL_OUTPUT.md if interested in full output.
