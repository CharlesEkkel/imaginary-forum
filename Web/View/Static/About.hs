module Web.View.Static.About where

import Web.View.Prelude

data AboutView = AboutView

instance View AboutView where
    html AboutView =
        [hsx|
            <div>
                Hello there good friend.
            </div>
        |]
