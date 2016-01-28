Observed, buggy behavior:

    $ for prefix in "+" "-"; do \
        cabal configure --flags="${prefix}cabal_flag" && \
        cabal build -j1 && \
        cabal copy \
        && .cabal-sandbox/bin/bug; \
      done
    Resolving dependencies...
    Configuring cabal-hsc2hs-bug-0.1.0.0...
    Building cabal-hsc2hs-bug-0.1.0.0...
    Preprocessing library cabal-hsc2hs-bug-0.1.0.0...
    [1 of 2] Compiling HSC              ( dist/build/HSC.hs, dist/build/HSC.o )
    [2 of 2] Compiling HS               ( src/HS.hs, dist/build/HS.o )
    In-place registering cabal-hsc2hs-bug-0.1.0.0...
    Preprocessing executable 'bug' for cabal-hsc2hs-bug-0.1.0.0...
    [1 of 1] Compiling Main             ( bug/Main.hs, dist/build/bug/bug-tmp/Main.o )
    Linking dist/build/bug/bug ...
    Installing library in
    /home/conathan/prattle/cabal-hsc2hs-bug/.cabal-sandbox/lib/x86_64-linux-ghc-7.10.2/cabal_2eU3I5w1zhAHd2dFe1rPnj
    Installing executable(s) in
    /home/conathan/prattle/cabal-hsc2hs-bug/.cabal-sandbox/bin
    Warning: The directory
    /home/conathan/prattle/cabal-hsc2hs-bug/.cabal-sandbox/bin is not in the
    system search path.
    hsTest  = True
    hscTest = True
    Resolving dependencies...
    Configuring cabal-hsc2hs-bug-0.1.0.0...
    Building cabal-hsc2hs-bug-0.1.0.0...
    Preprocessing library cabal-hsc2hs-bug-0.1.0.0...
    [1 of 2] Compiling HSC              ( dist/build/HSC.hs, dist/build/HSC.o ) [flags changed]
    [2 of 2] Compiling HS               ( src/HS.hs, dist/build/HS.o ) [flags changed]
    In-place registering cabal-hsc2hs-bug-0.1.0.0...
    Preprocessing executable 'bug' for cabal-hsc2hs-bug-0.1.0.0...
    [1 of 1] Compiling Main             ( bug/Main.hs, dist/build/bug/bug-tmp/Main.o ) [HS changed]
    Linking dist/build/bug/bug ...
    Installing library in
    /home/conathan/prattle/cabal-hsc2hs-bug/.cabal-sandbox/lib/x86_64-linux-ghc-7.10.2/cabal_2eU3I5w1zhAHd2dFe1rPnj
    Installing executable(s) in
    /home/conathan/prattle/cabal-hsc2hs-bug/.cabal-sandbox/bin
    Warning: The directory
    /home/conathan/prattle/cabal-hsc2hs-bug/.cabal-sandbox/bin is not in the
    system search path.
    hsTest  = False
    hscTest = True

Expected behavior:

    $ for prefix in "+" "-"; do \
        touch src/HSC.hsc && \
        cabal configure --flags="${prefix}cabal_flag" && \
        cabal build -j1 && \
        cabal copy \
        && .cabal-sandbox/bin/bug; \
      done
    Resolving dependencies...
    Configuring cabal-hsc2hs-bug-0.1.0.0...
    Building cabal-hsc2hs-bug-0.1.0.0...
    Preprocessing library cabal-hsc2hs-bug-0.1.0.0...
    [1 of 2] Compiling HS               ( src/HS.hs, dist/build/HS.o ) [flags changed]
    [2 of 2] Compiling HSC              ( dist/build/HSC.hs, dist/build/HSC.o )
    In-place registering cabal-hsc2hs-bug-0.1.0.0...
    Preprocessing executable 'bug' for cabal-hsc2hs-bug-0.1.0.0...
    [1 of 1] Compiling Main             ( bug/Main.hs, dist/build/bug/bug-tmp/Main.o ) [HS changed]
    Linking dist/build/bug/bug ...
    Installing library in
    /home/conathan/prattle/cabal-hsc2hs-bug/.cabal-sandbox/lib/x86_64-linux-ghc-7.10.2/cabal_2eU3I5w1zhAHd2dFe1rPnj
    Installing executable(s) in
    /home/conathan/prattle/cabal-hsc2hs-bug/.cabal-sandbox/bin
    Warning: The directory
    /home/conathan/prattle/cabal-hsc2hs-bug/.cabal-sandbox/bin is not in the
    system search path.
    hsTest  = True
    hscTest = True
    Resolving dependencies...
    Configuring cabal-hsc2hs-bug-0.1.0.0...
    Building cabal-hsc2hs-bug-0.1.0.0...
    Preprocessing library cabal-hsc2hs-bug-0.1.0.0...
    [1 of 2] Compiling HS               ( src/HS.hs, dist/build/HS.o ) [flags changed]
    [2 of 2] Compiling HSC              ( dist/build/HSC.hs, dist/build/HSC.o )
    In-place registering cabal-hsc2hs-bug-0.1.0.0...
    Preprocessing executable 'bug' for cabal-hsc2hs-bug-0.1.0.0...
    [1 of 1] Compiling Main             ( bug/Main.hs, dist/build/bug/bug-tmp/Main.o ) [HS changed]
    Linking dist/build/bug/bug ...
    Installing library in
    /home/conathan/prattle/cabal-hsc2hs-bug/.cabal-sandbox/lib/x86_64-linux-ghc-7.10.2/cabal_2eU3I5w1zhAHd2dFe1rPnj
    Installing executable(s) in
    /home/conathan/prattle/cabal-hsc2hs-bug/.cabal-sandbox/bin
    Warning: The directory
    /home/conathan/prattle/cabal-hsc2hs-bug/.cabal-sandbox/bin is not in the
    system search path.
    hsTest  = False
    hscTest = False
