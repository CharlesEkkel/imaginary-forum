module Web.FrontController where

import IHP.RouterPrelude
import Web.Controller.Prelude
-- Controller Imports
import Web.Controller.Static
import Web.View.Layout (defaultLayout)

instance FrontController WebApplication where
    controllers =
        [ startPage WelcomeAction
        -- Generator Marker
        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAutoRefresh
