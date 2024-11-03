module Web.Controller.Threads where

import Web.Controller.Prelude
import Web.View.Threads.Index
import Web.View.Threads.New
import Web.View.Threads.Edit
import Web.View.Threads.Show

instance Controller ThreadsController where
    action ThreadsAction = do
        (threadsQ, pagination) <- query @Thread |> paginate
        threads <- threadsQ |> fetch
        render IndexView { .. }

    action NewThreadAction = do
        let thread = newRecord
        render NewView { .. }

    action ShowThreadAction { threadId } = do
        thread <- fetch threadId
        render ShowView { .. }

    action EditThreadAction { threadId } = do
        thread <- fetch threadId
        render EditView { .. }

    action UpdateThreadAction { threadId } = do
        thread <- fetch threadId
        thread
            |> buildThread
            |> ifValid \case
                Left thread -> render EditView { .. }
                Right thread -> do
                    thread <- thread |> updateRecord
                    setSuccessMessage "Thread updated"
                    redirectTo EditThreadAction { .. }

    action CreateThreadAction = do
        let thread = newRecord @Thread
        thread
            |> buildThread
            |> ifValid \case
                Left thread -> render NewView { .. } 
                Right thread -> do
                    thread <- thread |> createRecord
                    setSuccessMessage "Thread created"
                    redirectTo ThreadsAction

    action DeleteThreadAction { threadId } = do
        thread <- fetch threadId
        deleteRecord thread
        setSuccessMessage "Thread deleted"
        redirectTo ThreadsAction

buildThread thread = thread
    |> fill @'["userId", "title"]
