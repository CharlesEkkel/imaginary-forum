module Web.Types where

import Generated.Types
import IHP.ModelSupport
import IHP.Prelude

data WebApplication = WebApplication deriving (Eq, Show)

data StaticController = WelcomeAction deriving (Eq, Show, Data)

data ThreadsController
    = ThreadsAction
    | NewThreadAction
    | ShowThreadAction { threadId :: !(Id Thread) }
    | CreateThreadAction
    | EditThreadAction { threadId :: !(Id Thread) }
    | UpdateThreadAction { threadId :: !(Id Thread) }
    | DeleteThreadAction { threadId :: !(Id Thread) }
    deriving (Eq, Show, Data)
