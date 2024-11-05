module Web.View.Post.Edit where

import Web.View.Prelude

data EditView = EditView {post :: Post}

instance View EditView where
    html EditView {..} =
        [hsx|
        {breadcrumb}
        <h1>Edit Post</h1>
        {renderForm post}
    |]
      where
        breadcrumb =
            renderBreadcrumb
                [ breadcrumbLink "Posts" PostsAction
                , breadcrumbText "Edit Post"
                ]

renderForm :: Post -> Html
renderForm post =
    formFor
        post
        [hsx|
            {(textField #userId)}
            {(textField #threadId)}
            {(textField #content)}
            {submitButton}
        |]
