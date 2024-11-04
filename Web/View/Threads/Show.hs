module Web.View.Threads.Show where

import Web.View.Prelude

data ShowView = ShowView {thread :: Thread}

instance View ShowView where
    html ShowView {..} =
        [hsx|
            {breadcrumb}
            <h1>Show Thread</h1>
            <p>{thread}</p>
        |]
      where
        breadcrumb =
            renderBreadcrumb
                [ breadcrumbLink "Home" ThreadsAction
                , breadcrumbText "Show Thread"
                ]
