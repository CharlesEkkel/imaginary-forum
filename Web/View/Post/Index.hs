module Web.View.Post.Index where

import Web.View.Prelude

data IndexView = IndexView {post :: [Post], pagination :: Pagination}

instance View IndexView where
    html IndexView {..} =
        [hsx|
        |]
