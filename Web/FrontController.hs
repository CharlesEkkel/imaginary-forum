module Web.FrontController where

import IHP.RouterPrelude
-- Controller Imports

import IHP.Welcome.Controller (WelcomeController)
import Web.Controller.Prelude
import Web.Controller.Static
import Web.Controller.Threads
import Web.View.Layout (defaultLayout)

instance FrontController WebApplication where
    controllers =
        [ startPage ThreadsAction
        , parseRoute @StaticController
        , parseRoute @ThreadsController
        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAutoRefresh
