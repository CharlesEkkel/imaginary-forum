module Main where

import Config
import IHP.FrameworkConfig
import IHP.Job.Types
import IHP.Prelude
import IHP.RouterSupport
import IHP.Server qualified
import Web.FrontController
import Web.Types

instance FrontController RootApplication where
    controllers =
        [ mountFrontController WebApplication
        ]

instance Worker RootApplication where
    workers _ = []

main :: IO ()
main = IHP.Server.run config
