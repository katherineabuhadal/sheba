class RecipesController < PostsController

  private

  def post
    @_post ||= params[:id] ? Recipe.find_by(permalink: params[:id]) : Recipe.new(post_params)
  end
  helper_method :post

  private

  def post_params
    (params[:recipe] || ActionController::Parameters.new({})).permit(
      :title,
      :content,
      :published_at,
      :published,
      :external_link,
      :style,
      :tag_list,
      :ingredient_list,
      :category_list,
      :ingredients,
      :instructions,
      :permalink
    )
  end

end
