module Web.View.Layout (defaultLayout, Html) where

import Application.Helper.View
import Generated.Types
import IHP.Controller.RequestContext
import IHP.Environment
import IHP.ViewPrelude
import Web.Routes
import Web.Types

defaultLayout :: Html -> Html
defaultLayout inner =
    [hsx|
        <!DOCTYPE html>
        <html lang="en">
            <head>
                {metaTags}

                {stylesheets}
                {scripts}

                <title>{pageTitleOrDefault "AI Forum"}</title>
            </head>
            <body>
                <div class="container">
                    {renderFlashMessages}
                    {header}

                    <main>
                        {inner}
                    </main>
                </div>
            </body>
        </html>
    |]

header :: Html
header =
    [hsx|
        <header class="row mb-4 sticky-top rounded-bottom">
            <nav class="navbar container" aria-label="High-level page links">
                <div class="container-fluid d-flex flex-row justify-content-between">
                    <a class="navbar-brand" href="/">The Imaginary Forum</a>
                    <ul class="navbar-nav hstack gap-4">
                        <li class="nav-item">
                            <a href={ThreadsAction} 
                               aria-current={isFrontPage `ifTrueThen` "page"}
                               class={classes ["nav-link", ("active", isFrontPage)]}>
                                Home
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href={AboutAction} 
                               aria-current={isAboutPage `ifTrueThen` "page"}
                               class={classes ["nav-link", ("active", isAboutPage)]}>
                                About
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href={UsersAction} 
                               aria-current={isLoginSection `ifTrueThen` "page"}
                               class={classes ["btn btn-outline-primary", ("active", isLoginSection)]}>
                                {svgIcon "square-plus"}
                                Login
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>
        </header>
    |]
  where
    isFrontPage = isActiveAction ThreadsAction || isActivePath ("/" :: Text)
    isAboutPage = isActiveAction AboutAction
    isLoginSection = isActiveController @UsersController

-- The 'assetPath' function used below appends a `?v=SOME_VERSION` to the static assets in production
-- This is useful to avoid users having old CSS and JS files in their browser cache once a new version is deployed
-- See https://ihp.digitallyinduced.com/Guide/assets.html for more details

stylesheets :: Html
stylesheets =
    [hsx|
        <link rel="stylesheet" href={assetPath "/vendor/bootstrap-5.2.1/bootstrap.min.css"}/>
        <link rel="stylesheet" href={assetPath "/vendor/flatpickr.min.css"}/>
        <link rel="stylesheet" href={assetPath "/app.css"}/>
    |]

scripts :: Html
scripts =
    [hsx|
        {when isDevelopment devScripts}
        <script src={assetPath "/vendor/timeago.js"}></script>
        <script src={assetPath "/vendor/popper-2.11.6.min.js"}></script>
        <script src={assetPath "/vendor/bootstrap-5.2.1/bootstrap.min.js"}></script>
        <script src={assetPath "/vendor/flatpickr.js"}></script>
        <script src={assetPath "/vendor/morphdom-umd.min.js"}></script>
        <script src={assetPath "/vendor/turbolinks.js"}></script>
        <script src={assetPath "/vendor/turbolinksInstantClick.js"}></script>
        <script src={assetPath "/vendor/turbolinksMorphdom.js"}></script>
        <script src={assetPath "/helpers.js"}></script>
        <script src={assetPath "/ihp-auto-refresh.js"}></script>
        <script src={assetPath "/app.js"}></script>
    |]

devScripts :: Html
devScripts =
    [hsx|
        <script id="livereload-script" src={assetPath "/livereload.js"} data-ws={liveReloadWebsocketUrl}></script>
    |]

metaTags :: Html
metaTags =
    [hsx|
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
        <meta property="og:title" content="App"/>
        <meta property="og:type" content="website"/>
        <meta property="og:url" content="TODO"/>
        <meta property="og:description" content="TODO"/>
        {autoRefreshMeta}
    |]
