class CommentsController < ApplicationController

  def new
  end

  def create
    set_user
    if comment.save(comment_params)
      message(:notice, :saved)
      redirect_to post
    else
      render "posts/show"
    end
  end

  private

  def comment
    @_comment ||= post.comments.new(comment_params)
  end
  helper_method :comment

  def post
    @_post ||= Post.find_by(permalink: post_id)
  end
  helper_method :post

  def post_id
    params[:recipe_id] ? params[:recipe_id] : params[:content_id]
  end

  def comment_params
    params.require(:comment).permit(
      :name,
      :content,
    )
  end

  def set_user
    return unless current_user
    comment.user = current_user
    comment.name = current_user.name
  end
end
