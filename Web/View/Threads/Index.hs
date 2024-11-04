{-# LANGUAGE OverloadedRecordDot #-}

module Web.View.Threads.Index where

import Web.View.Prelude

data IndexView = IndexView {threads :: [Thread], pagination :: Pagination}

instance View IndexView where
    html IndexView {..} =
        [hsx|
        {breadcrumb}

        <div class="hstack mb-4">
            <h1 class="h3 me-auto">Latest Discussions</h1>
            <a class="btn btn-primary hstack gap-2" href={NewThreadAction}>
                <svg width="16" height="16">
                    <use href={assetPath "/icons/square-plus.svg" ++ "#plus"}/>
                </svg>
                New Discussion
            </a>
        </div>
            
        <div class="container g-2">
            <span class="row row-cols-1 row-cols-lg-2">
                {forEach threads renderThread}
            </span>
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
        <div class="col mb-4">
            <article class="card shadow-sm">
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
        </div>
    |]
  where
    timeOfCreation =
        thread.updatedAt
            |> formatTime defaultTimeLocale "%Y-%m-%d, %H:%M:%S"
