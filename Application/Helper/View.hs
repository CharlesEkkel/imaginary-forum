module Application.Helper.View where

import IHP.ViewPrelude

-- Here you can add functions which are available in all your views

svgIcon :: Text -> Html
svgIcon iconName =
    [hsx|
        <svg width="16" height="16">
            <use href={assetPath ("/icons/" <> iconName <> ".svg") <> "#" <> iconName}/>
        </svg>
    |]
