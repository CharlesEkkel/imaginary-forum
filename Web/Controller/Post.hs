{-# LANGUAGE OverloadedRecordDot #-}

module Web.Controller.Post where

import Web.Controller.Prelude
import Web.View.Post.Edit
import Web.View.Post.Index
import Web.View.Post.New
import Web.View.Post.Show

instance Controller PostController where
    action PostsAction = do
        (postQ, pagination) <- query @Post |> paginate
        post <- postQ |> fetch
        render IndexView {..}
    action NewPostAction {currentThreadId} = do
        currentThread <- fetch currentThreadId
        let
            post = newRecord

        render NewView {..}
    action ShowPostAction {postId} = do
        post <- fetch postId
        currentThread <- fetch post.threadId
        render ShowView {..}
    action EditPostAction {postId} = do
        post <- fetch postId
        render EditView {..}
    action UpdatePostAction {postId} = do
        post <- fetch postId
        post
            |> buildPost
            |> ifValid \case
                Left post -> render EditView {..}
                Right post -> do
                    post <- post |> updateRecord
                    setSuccessMessage "Post updated"
                    redirectTo EditPostAction {..}
    action CreatePostAction {currentThreadId} = do
        currentThread <- fetch currentThreadId
        let
            post = newRecord @Post
        post
            |> buildPost
            |> ifValid \case
                Left post -> render NewView {..}
                Right post -> do
                    let
                        -- fullPost = (post :: Post) {threadId = currentThreadId}
                        fullPost =
                            post
                                |> set (Proxy :: Proxy "threadId") currentThreadId
                                |> set (Proxy :: Proxy "userId") "056fbcb1-3a2b-453e-b339-641ac58a33a7"

                    post <- fullPost |> createRecord
                    setSuccessMessage "Post created"
                    redirectTo PostsAction
    action DeletePostAction {postId} = do
        post <- fetch postId
        deleteRecord post
        setSuccessMessage "Post deleted"
        redirectTo PostsAction

buildPost post =
    post
        |> fill @'["userId", "title", "content"]
