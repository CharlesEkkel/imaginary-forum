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
    <article class="card col-12 col-md-6">
        <h2 class="h5 card-header">
            {thread.title}
        </h2>
        <div class="card-body">
            <p>
                Several more details here...
            </p>
            <div class="hstack gap-2">
                <a class="btn btn-primary" href={ShowThreadAction thread.id}>Show</a>
                <a class="btn btn-outline-primary " href={EditThreadAction thread.id}>Edit</a>
                <a class="btn btn-outline-primary js-delete" href={DeleteThreadAction thread.id}>Delete</a>
            </div>
        </div>
    </article>
|]
