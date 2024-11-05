{-# LANGUAGE OverloadedRecordDot #-}

module Web.View.Post.Show where

import Web.View.Prelude

data ShowView = ShowView {post :: Post, currentThread :: Thread}

instance View ShowView where
    html ShowView {..} =
        [hsx|
        {breadcrumb}
        <h1 class="h3">{post.title}</h1>
        <p>{post.content}</p>

    |]
      where
        breadcrumb =
            renderBreadcrumb
                [ breadcrumbLink "Home" ThreadsAction
                , breadcrumbLink [hsx|{currentThread.title}|] (ShowThreadAction currentThread.id)
                , breadcrumbText (toHtml post.title)
                ]
