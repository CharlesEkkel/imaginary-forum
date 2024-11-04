{-# LANGUAGE OverloadedRecordDot #-}

module Web.View.Threads.Index where

import Web.View.Prelude

data IndexView = IndexView {threads :: [Thread], pagination :: Pagination}

instance View IndexView where
    html IndexView {..} =
        [hsx|
        {breadcrumb}

        <h1 class="h3 mb-4">Latest Discussions</h1>
            
        <div class="container">
            {forEach threads renderThread}
        </div>
        {renderPagination pagination}
    |]
      where
        breadcrumb =
            renderBreadcrumb
                [ breadcrumbText "Home"
                ]

renderThread :: Thread -> Html
renderThread thread =
    [hsx|
        <article class="card shadow-sm col-12 col-md-6">
            <h2 class="h5 card-header">
                {thread.title}
            </h2>
            <div class="card-body">
                <p class="card-text">
                    Several more details here...
                </p>
                <p class="card-text text-muted">
                    Last updated {timeOfCreation}
                </p>
                <div class="hstack gap-2">
                    <a class="btn btn-outline-primary stretched-link" href={ShowThreadAction thread.id}>Comments</a>
                </div>
            </div>
        </article>
    |]
  where
    timeOfCreation =
        thread.updatedAt
            |> formatTime defaultTimeLocale "%Y-%m-%d, %H:%M:%S"
