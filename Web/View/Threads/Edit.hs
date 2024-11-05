module Web.View.Threads.Edit where

import Web.View.Prelude

data EditView = EditView {thread :: Thread}

instance View EditView where
    html EditView {..} =
        [hsx|
            {breadcrumb}
            <h1>Edit Thread</h1>
            {renderForm thread}
        |]
      where
        breadcrumb =
            renderBreadcrumb
                [ breadcrumbLink "Home" ThreadsAction
                , breadcrumbText "Edit Thread"
                ]

renderForm :: Thread -> Html
renderForm thread =
    formFor
        thread
        [hsx|
            {(textField #userId)}
            {(textField #title)}
            {(textField #description)}
            {submitButton}
        |]
