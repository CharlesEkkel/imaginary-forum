{-# LANGUAGE OverloadedRecordDot #-}

module Web.Controller.Comments where

import Web.Controller.Prelude
import Web.View.Comments.Edit
import Web.View.Comments.Index
import Web.View.Comments.New
import Web.View.Comments.Show

instance Controller CommentsController where
    action CommentsAction = do
        (commentsQ, pagination) <- query @Comment |> paginate
        comments <- commentsQ |> fetch
        render IndexView {..}
    action NewCommentAction {currentPostId} = do
        post <- fetch currentPostId
        thread <- fetch post.threadId
        let
            comment = newRecord
        render NewView {..}
    action ShowCommentAction {commentId} = do
        comment <- fetch commentId
        render ShowView {..}
    action EditCommentAction {commentId} = do
        comment <- fetch commentId
        render EditView {..}
    action UpdateCommentAction {commentId} = do
        comment <- fetch commentId
        comment
            |> buildComment
            |> ifValid \case
                Left comment -> render EditView {..}
                Right comment -> do
                    comment <- comment |> updateRecord
                    setSuccessMessage "Comment updated"
                    redirectTo EditCommentAction {..}
    action CreateCommentAction {currentPostId} = do
        post <- fetch currentPostId
        let
            comment = newRecord @Comment
        comment
            |> buildComment
            |> ifValid \case
                Left comment -> do
                    thread <- fetch post.threadId
                    render NewView {..}
                Right comment -> do
                    comment <-
                        comment
                            |> set (Proxy :: Proxy "userId") "056fbcb1-3a2b-453e-b339-641ac58a33a7"
                            |> set (Proxy :: Proxy "threadId") post.threadId
                            |> set (Proxy :: Proxy "postId") post.id
                            |> createRecord

                    setSuccessMessage "Comment created"
                    redirectTo $ ShowPostAction post.id
    action DeleteCommentAction {commentId} = do
        comment <- fetch commentId
        deleteRecord comment
        setSuccessMessage "Comment deleted"
        redirectTo $ ShowPostAction comment.postId

buildComment comment =
    comment
        |> fill @'["content"]
