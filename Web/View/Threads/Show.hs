{-# LANGUAGE OverloadedRecordDot #-}

module Web.View.Threads.Show where

import Web.View.Prelude

data ShowView = ShowView {thread :: Thread, posts :: [Post], pagination :: Pagination}

instance View ShowView where
    html ShowView {..} =
        [hsx|
            {breadcrumb}
            <div class="hstack">
                <h1>{thread.title}</h1>
                <a href={NewPostAction thread.id}>New Post</a>
            </div>
            <p>{thread.description}</p>
            <div class="container">
                <ol class="list-group">
                    {forEach posts renderPost}
                </ol>
                
                    <tbody></tbody>
                {renderPagination pagination}
            </div>
        |]
      where
        breadcrumb =
            renderBreadcrumb
                [ breadcrumbLink "Home" ThreadsAction
                , breadcrumbText (toHtml thread.title)
                ]

renderPost :: Post -> Html
renderPost post =
    [hsx|
        <li class="list-group-item vstack g-2">
            <h2>{post.title}</h2>
            <p>{post.content}</p>
            <a href={ShowPostAction post.id}>Show</a>
            <a href={EditPostAction post.id} class="text-muted">Edit</a>
            <a href={DeletePostAction post.id} class="js-delete text-muted">Delete</a>
        </li>
    |]
