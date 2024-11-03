module Web.View.Threads.New where
import Web.View.Prelude

data NewView = NewView { thread :: Thread }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New Thread</h1>
        {renderForm thread}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Threads" ThreadsAction
                , breadcrumbText "New Thread"
                ]

renderForm :: Thread -> Html
renderForm thread = formFor thread [hsx|
    {(textField #userId)}
    {(textField #title)}
    {submitButton}

|]