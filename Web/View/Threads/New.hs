{-# LANGUAGE OverloadedRecordDot #-}

module Web.View.Threads.New where

import Web.View.Prelude

data NewView = NewView {thread :: Thread, users :: [User]}

instance View NewView where
    html NewView {..} =
        [hsx|
        {breadcrumb}
        <h1>New Thread</h1>
        {renderForm users thread}
    |]
      where
        breadcrumb =
            renderBreadcrumb
                [ breadcrumbLink "Threads" ThreadsAction
                , breadcrumbText "New Thread"
                ]

renderForm :: [User] -> Thread -> Html
renderForm users thread =
    formFor
        thread
        [hsx|
            {(selectField #userId users)}
            {(textField #title)}
            {submitButton}
        |]

instance CanSelect User where
    type SelectValue User = Id User
    selectValue user = user.id
    selectLabel user = user.firstName
