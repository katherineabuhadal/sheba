class CommentsController < ApplicationController

  def new
  end

  def create
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
    @_post ||= Post.find_by(permalink: params[:post_id])
  end
  helper_method :post

  def comment_params
    params.require(:comment).permit(
      :name,
      :content,
    )
  end
end
