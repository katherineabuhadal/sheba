class RecipesController < PostsController

  private

  def post
    @_post ||= params[:id] ? Post.find_by(permalink: params[:id]) : Post.new(post_params)
  end
  helper_method :post

  def post_params
    (params[:recipe] || ActionController::Parameters.new({})).permit(
      :title,
      :content,
      :published_at,
      :published,
      :external_link,
      :style,
      :ingredients,
      :instructions,
      :permalink,
      :tag_list,
      :ingredient_tag_list,
      :category_tag_list,
      { video_links_attributes: [ :url, :language ] }
    )
  end

end
