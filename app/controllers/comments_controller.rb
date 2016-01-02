class CommentsController < ApplicationController

  def new
  end

  def create
    if comment.save(comment_params)
      message(:notice, :saved)
      redirect_to recipe
    else
      render "recipes/show"
    end
  end

  private

  def comment
    @_comment ||= recipe.comments.new(comment_params)
  end
  helper_method :comment

  def recipe
    @_recipe ||= Recipe.find_by(permalink: params[:recipe_id])
  end
  helper_method :recipe

  def comment_params
    params.require(:comment).permit(
      :name,
      :content,
    )
  end
end
