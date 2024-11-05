{-# LANGUAGE OverloadedRecordDot #-}

module Web.View.Post.Edit where

import Web.View.Prelude

data EditView = EditView {post :: Post, currentThread :: Thread}

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
                [ breadcrumbLink "Home" ThreadsAction
                , breadcrumbLink (toHtml currentThread.title) (ShowThreadAction currentThread.id)
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
