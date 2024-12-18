module Web.View.Users.New where

import Web.View.Prelude

data NewView = NewView {user :: User}

instance View NewView where
    html NewView {..} =
        [hsx|
        {breadcrumb}
        <h1 class="h3">New User</h1>
        {renderForm user}
    |]
      where
        breadcrumb =
            renderBreadcrumb
                [ breadcrumbLink "Home" ThreadsAction
                , breadcrumbLink "Users" UsersAction
                , breadcrumbText "New User"
                ]

renderForm :: User -> Html
renderForm user =
    formFor
        user
        [hsx|
            {(textField #email)}
            {(textField #firstName)}
            {(textField #middleName)}
            {(textField #lastName)}
            {(textField #username)}
            {submitButton}
        |]
