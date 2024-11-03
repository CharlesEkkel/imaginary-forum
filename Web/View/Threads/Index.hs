module Web.View.Threads.Index where

import Web.View.Prelude

data IndexView = IndexView {threads :: [Thread], pagination :: Pagination}

instance View IndexView where
    html IndexView {..} =
        [hsx|
        {breadcrumb}

        <h1 class="h3">Latest Discussions</h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Thread</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach threads renderThread}</tbody>
            </table>
            {renderPagination pagination}
        </div>
    |]
      where
        breadcrumb =
            renderBreadcrumb
                [ breadcrumbText "Home"
                ]

renderThread :: Thread -> Html
renderThread thread =
    [hsx|
    <tr>
        <td>{thread.title}</td>
        <td><a href={ShowThreadAction thread.id}>Show</a></td>
        <td><a href={EditThreadAction thread.id} class="text-muted">Edit</a></td>
        <td><a href={DeleteThreadAction thread.id} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
