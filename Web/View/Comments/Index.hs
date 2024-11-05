module Web.View.Comments.Index where

import Web.View.Prelude

data IndexView = IndexView {comments :: [Comment], pagination :: Pagination}

instance View IndexView where
    html IndexView {..} =
        [hsx|
        |]
      where
        breadcrumb =
            renderBreadcrumb
                [ breadcrumbLink "Comments" CommentsAction
                ]
