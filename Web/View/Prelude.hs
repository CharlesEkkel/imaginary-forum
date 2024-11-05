{-# LANGUAGE OverloadedRecordDot #-}

module Web.View.Prelude (
    module IHP.ViewPrelude,
    module Web.View.Layout,
    module Generated.Types,
    module Web.Types,
    module Application.Helper.View,
) where

import Application.Helper.View
import Generated.Types
import IHP.ViewPrelude
import Web.Routes ()
import Web.Types
import Web.View.Layout

instance CanSelect User where
    type SelectValue User = Id User
    selectValue user = user.id
    selectLabel user = user.firstName
