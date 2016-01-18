class ContentController < PostsController

  private

  def post
    @_post ||= Content.find_by(permalink: params[:id])
  end
  helper_method :post

  private

  def post_params
    (params[:content] || ActionController::Parameters.new({})).permit(
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
