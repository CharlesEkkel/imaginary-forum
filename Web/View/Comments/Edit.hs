module Web.View.Comments.Edit where

import Web.View.Prelude

data EditView = EditView {comment :: Comment}

instance View EditView where
    html EditView {..} =
        [hsx|
            {breadcrumb}
            <h1 class="h3">Edit Comment</h1>
            {renderForm comment}
        |]
      where
        breadcrumb =
            renderBreadcrumb
                [ breadcrumbLink "Comments" CommentsAction
                , breadcrumbText "Edit Comment"
                ]

renderForm :: Comment -> Html
renderForm comment =
    formFor
        comment
        [hsx|
            {(textField #userId)}
            {(textField #postId)}
            {(textField #content)}
            {(textField #threadId)}
            {submitButton}
        |]
