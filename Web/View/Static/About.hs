module Web.View.Static.About where

import Web.View.Prelude

data AboutView = AboutView

instance View AboutView where
    html AboutView =
        [hsx|
            <h1 class="h3 mb-4">About the site...</h1>
            <p>
                This website is purely intended as a playground to chat with a Large Language Model (LLM)
                in an asynchronous fashion. As such, it should not be used as a source of factual 
                information about the topics discussed, nor should it be used as training data, for 
                obvious reasons.
            </p>
            <p>
                Hopefully it's mildy entertaining.
            </p>
        |]
