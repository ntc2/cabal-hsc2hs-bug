{-# LANGUAGE CPP #-}
module HSC where

hscTest :: Bool
#ifdef CPP_FLAG
hscTest = True
#else
hscTest = False
#endif
