{-# LANGUAGE OverloadedRecordDot #-}

module Web.View.Post.New where

import Web.View.Prelude

data NewView = NewView {post :: Post, currentThread :: Thread}

instance View NewView where
    html NewView {..} =
        [hsx|
            {breadcrumb}
            <h1>New Post</h1>
            {renderForm currentThread post}
        |]
      where
        breadcrumb =
            renderBreadcrumb
                [ breadcrumbLink "Home" ThreadsAction
                , breadcrumbLink (toHtml currentThread.title) (ShowThreadAction currentThread.id)
                , breadcrumbText "New Post"
                ]

renderForm :: Thread -> Post -> Html
renderForm thread post =
    formFor'
        post
        (pathTo $ CreatePostAction thread.id)
        [hsx|
            {(textField #title)}
            {(textareaField #content)}
            {submitButton}
        |]
