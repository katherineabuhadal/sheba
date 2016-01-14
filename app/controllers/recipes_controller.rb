class RecipesController < PostsController

  private

  def post
    @_post ||= params[:id] ? Recipe.find_by(permalink: params[:id]) : Recipe.new(post_params)
  end
  helper_method :post


end
