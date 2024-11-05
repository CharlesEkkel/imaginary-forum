{-# LANGUAGE OverloadedRecordDot #-}

module Web.View.Post.Show where

import Web.View.Prelude

data ShowView = ShowView {post :: Post, currentThread :: Thread, comments :: [(User, Comment)], pagination :: Pagination}

instance View ShowView where
    html ShowView {..} =
        [hsx|
            {breadcrumb}
            <h1 class="h3">{post.title}</h1>
            <p>{post.content}</p>

            <div class="container">
                <ol class="list-group">
                    {forEach comments renderComment}
                </ol>
                <a class="btn btn-primary" href={NewCommentAction post.id}>New Comment</a>
                
                {renderPagination pagination}
            </div>
        |]
      where
        breadcrumb =
            renderBreadcrumb
                [ breadcrumbLink "Home" ThreadsAction
                , breadcrumbLink (toHtml currentThread.title) (ShowThreadAction currentThread.id)
                , breadcrumbText (toHtml post.title)
                ]

renderComment :: (User, Comment) -> Html
renderComment (user, comment) =
    [hsx|
        <li class="list-group-item vstack g-2">
            <h2>{user.username}</h2>
            <p>{comment.content}</p>
            <a href={ShowCommentAction comment.id}>Show</a>
            <a href={EditCommentAction comment.id} class="text-muted">Edit</a>
            <a href={DeleteCommentAction comment.id} class="js-delete text-muted">Delete</a>
        </li>
    |]
