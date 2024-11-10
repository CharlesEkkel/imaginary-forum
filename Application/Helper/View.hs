module Application.Helper.View where

import IHP.ViewPrelude
import Web.Controller.Prelude (getHeader)
import Web.Cookie (parseCookiesText)

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

getCookie :: (?context :: ControllerContext) => Text -> Maybe Text
getCookie cookieName = do
    allCookies <- getHeader "Cookie"
    let
        cookieList = parseCookiesText allCookies
    cookie <- find (\x -> fst x == cookieName) cookieList
    pure $ snd cookie

getThemeName :: (?context :: ControllerContext) => Text
getThemeName = fromMaybe "zephr" $ getCookie "ThemeName"

getDarkMode :: (?context :: ControllerContext) => Text
getDarkMode = fromMaybe "disabled" $ getCookie "DarkMode"
