module Web.View.HeaderLayout where

import IHP.ViewPrelude

-- import Application.Helper.View

headerLayout :: Html -> Html
headerLayout inner =
    [hsx|
        <header class="row navbar text-bg-light mb-4">
            <nav class="container">
                <a class="navbar-brand" href="/">The Imaginary Forum</a>
                <ul class="nav col flex-row">
                    <li class="nav-item">
                        <a href="/" class="nav-link">Home</a>
                    </li>
                    <li class="nav-item">
                        <a href="/login" class="btn btn-outline-primary">Login</a>
                    </li>
                </ul>
            </nav>
        </header>
        <main>
            {inner}
        </main>
    |]
