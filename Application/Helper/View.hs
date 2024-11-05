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

-- | Use concrete type Text to prevent overlapping instance complaints.
ifTrueThen :: Bool -> Text -> Maybe Text
ifTrueThen condition value = if condition then Just value else Nothing
