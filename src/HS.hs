{-# LANGUAGE CPP #-}
module HS where

hsTest :: Bool
#ifdef CPP_FLAG
hsTest = True
#else
hsTest = False
#endif
