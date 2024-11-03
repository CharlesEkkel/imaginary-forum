module Web.Controller.Static where

import Web.Controller.Prelude
import Web.View.Static.About

instance Controller StaticController where
    action AboutAction = render AboutView
