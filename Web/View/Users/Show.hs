module Web.View.Users.Show where

import Web.View.Prelude

data ShowView = ShowView {user :: User}

instance View ShowView where
    html ShowView {..} =
        [hsx|
        {breadcrumb}
        <h1 class="h3">Show User</h1>
        <p>{user}</p>

    |]
      where
        breadcrumb =
            renderBreadcrumb
                [ breadcrumbLink "Home" ThreadsAction
                , breadcrumbLink "Users" UsersAction
                , breadcrumbText "Show User"
                ]
