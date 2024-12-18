module Web.Types where

import Generated.Types
import IHP.ModelSupport
import IHP.Prelude

data WebApplication = WebApplication deriving (Eq, Show)

data StaticController = AboutAction deriving (Eq, Show, Data)

data ThreadsController
    = ThreadsAction
    | NewThreadAction
    | ShowThreadAction {threadId :: !(Id Thread)}
    | CreateThreadAction
    | EditThreadAction {threadId :: !(Id Thread)}
    | UpdateThreadAction {threadId :: !(Id Thread)}
    | DeleteThreadAction {threadId :: !(Id Thread)}
    deriving (Eq, Show, Data)

data PostController
    = PostsAction
    | NewPostAction {currentThreadId :: !(Id Thread)}
    | ShowPostAction {postId :: !(Id Post)}
    | CreatePostAction {currentThreadId :: !(Id Thread)}
    | EditPostAction {postId :: !(Id Post)}
    | UpdatePostAction {postId :: !(Id Post)}
    | DeletePostAction {postId :: !(Id Post)}
    deriving (Eq, Show, Data)

data UsersController
    = UsersAction
    | NewUserAction
    | ShowUserAction {userId :: !(Id User)}
    | CreateUserAction
    | EditUserAction {userId :: !(Id User)}
    | UpdateUserAction {userId :: !(Id User)}
    | DeleteUserAction {userId :: !(Id User)}
    deriving (Eq, Show, Data)

data CommentsController
    = CommentsAction
    | NewCommentAction {currentPostId :: !(Id Post)}
    | ShowCommentAction {commentId :: !(Id Comment)}
    | CreateCommentAction {currentPostId :: !(Id Post)}
    | EditCommentAction {commentId :: !(Id Comment)}
    | UpdateCommentAction {commentId :: !(Id Comment)}
    | DeleteCommentAction {commentId :: !(Id Comment)}
    deriving (Eq, Show, Data)

data ThemesController
    = ThemesAction
    | SetThemeAction {themeName :: Text}
    | ToggleDarkModeAction
    deriving (Eq, Show, Data)

data Theme = Theme
    { themeName :: Text
    }
    deriving (Eq, Show)
