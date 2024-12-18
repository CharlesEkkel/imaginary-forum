module Web.FrontController where

import IHP.RouterPrelude
-- Controller Imports

import Web.Controller.Comments
import Web.Controller.Post
import Web.Controller.Prelude
import Web.Controller.Static
import Web.Controller.Themes
import Web.Controller.Threads
import Web.Controller.Users
import Web.View.Layout (defaultLayout)

instance FrontController WebApplication where
    controllers =
        [ startPage ThreadsAction
        , parseRoute @StaticController
        , parseRoute @ThreadsController
        , parseRoute @PostController
        , parseRoute @UsersController
        , parseRoute @CommentsController
        , parseRoute @ThemesController
        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAutoRefresh
