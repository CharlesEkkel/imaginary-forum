module Web.Controller.Themes where

import Application.Helper.View (getDarkMode, getThemeName)
import BasicPrelude (encodeUtf8)
import Data.Text (toTitle)
import IHP.Controller.RequestContext (RequestContext (respond))
import Network.HTTP (respondHTTP)
import Web.Controller.Prelude
import Web.Cookie (
    SetCookie (setCookieMaxAge, setCookieName, setCookieSameSite, setCookieSecure, setCookieValue),
    defaultSetCookie,
    sameSiteNone,
 )
import Web.View.Themes.Index

allThemes = [Theme "journal", Theme "litera", Theme "pulse", Theme "quartz", Theme "sketchy", Theme "yeti", Theme "zephr"]

instance Controller ThemesController where
    action ThemesAction = do
        render $ IndexView allThemes
    action SetThemeAction {themeName} = do
        setSuccessMessage $ "Theme updated to: " <> toTitle themeName
        setCookie
            defaultSetCookie
                { setCookieName = "ThemeName"
                , setCookieValue = encodeUtf8 themeName
                , setCookieMaxAge = Just $ secondsToDiffTime (60 * 60 * 24 * 400) -- 400 days is maximum for chrome
                , setCookieSameSite = Just sameSiteNone
                , setCookieSecure = True
                }
        setHeader ("HX-Refresh", "true") -- force refresh of page after setting new theme
        respondHtml ""
    action ToggleDarkModeAction = do
        let
            toggledDarkModeStatus = if getDarkMode == "enabled" then "disabled" else "enabled"
        setSuccessMessage $ "Dark Mode " <> toTitle toggledDarkModeStatus
        setCookie
            defaultSetCookie
                { setCookieName = "DarkMode"
                , setCookieValue = encodeUtf8 $ toggledDarkModeStatus
                , setCookieMaxAge = Just $ secondsToDiffTime (60 * 60 * 24 * 400) -- 400 days is maximum for chrome
                , setCookieSameSite = Just sameSiteNone
                , setCookieSecure = True
                }
        setHeader ("HX-Refresh", "true") -- force refresh of page after setting new theme
        respondHtml ""
