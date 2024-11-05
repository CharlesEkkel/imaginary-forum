{-# LANGUAGE OverloadedRecordDot #-}

module Web.View.Threads.New where

import Web.View.Prelude

data NewView = NewView {thread :: Thread, users :: [User]}

instance View NewView where
    html NewView {..} =
        [hsx|
            {breadcrumb}
            <h1 class="h2 mb-4">Create a new thread</h1>
            {renderForm users thread}
        |]
      where
        breadcrumb =
            renderBreadcrumb
                [ breadcrumbLink "Home" ThreadsAction
                , breadcrumbText "New Thread"
                ]

renderForm :: [User] -> Thread -> Html
renderForm users thread =
    formFor
        thread
        [hsx|
            {(selectField #userId users)}
            {(textField #title)}
            {(textField #description)}
            {submitButton}
        |]
