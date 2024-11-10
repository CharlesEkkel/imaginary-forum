module Web.View.Themes.Index where

import Data.Text (toTitle)
import Web.View.Prelude

data IndexView = IndexView {themes :: [Theme]}

instance View IndexView where
    html IndexView {..} =
        [hsx|
        {breadcrumb}
        <div class="container">
            <h1 class="h3 mb-4">Theming options</h1>
            <fieldset class="vstack gap-2 mb-4">
                <legend>Styles</legend>
                {forEach themes renderTheme}
            </fieldset>
            <button 
                class="btn btn-primary mb-4" 
                id="darkModeSwitch"
                hx-post={ToggleDarkModeAction}
                >Toggle Dark Mode</button>
        </div>
    |]
      where
        breadcrumb =
            renderBreadcrumb
                [ breadcrumbLink "Home" ThreadsAction
                , breadcrumbText "Themes"
                ]

renderTheme :: Theme -> Html
renderTheme theme =
    [hsx|
    <div class="form-check">
        <input 
            type="radio"
            hx-trigger="change" 
            hx-post={SetThemeAction theme.themeName}
            class="form-check-input"
            name="options-base"
            id={theme.themeName}
            checked={theme.themeName == getThemeName}
            />
        <label 
            for={theme.themeName}
            class="form-check-label"
            >{toTitle theme.themeName}</label>
    </div>
|]
