module Web.View.Comments.Show where

import Web.View.Prelude

data ShowView = ShowView {comment :: Comment}

instance View ShowView where
    html ShowView {..} =
        [hsx|
            {breadcrumb}
            <h1 class="h3">Show Comment</h1>
            <p>{comment}</p>
        |]
      where
        breadcrumb =
            renderBreadcrumb
                [ breadcrumbLink "Comments" CommentsAction
                , breadcrumbText "Show Comment"
                ]
