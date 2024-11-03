module Web.FrontController where

import IHP.RouterPrelude
import Web.Controller.Prelude
-- Controller Imports

import Web.Controller.Static
import Web.Controller.Threads
import Web.View.Layout (defaultLayout)

instance FrontController WebApplication where
    controllers =
        [ startPage ThreadsAction
        , -- Generator Marker
          parseRoute @ThreadsController
        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAutoRefresh
