{-# LANGUAGE OverloadedRecordDot #-}

module Web.View.Comments.New where

import Web.View.Prelude

data NewView = NewView {comment :: Comment, post :: Post, thread :: Thread}

instance View NewView where
    html NewView {..} =
        [hsx|
            {breadcrumb}
            <h1 class="h3">New Comment</h1>
            {renderForm post comment}
        |]
      where
        breadcrumb =
            renderBreadcrumb
                [ breadcrumbLink "Home" ThreadsAction
                , breadcrumbLink (toHtml thread.title) (ShowThreadAction thread.id)
                , breadcrumbLink (toHtml post.title) (ShowPostAction post.id)
                , breadcrumbText "New Comment"
                ]

renderForm :: Post -> Comment -> Html
renderForm post comment =
    formFor'
        comment
        (pathTo $ CreateCommentAction post.id)
        [hsx|
            {(textField #content)}
            {submitButton}
        |]
