class ContentController < PostsController

  private

  def post
    @_post ||= Content.find_by(permalink: params[:id])
  end
  helper_method :post

  def post_params
    (params[:content] || ActionController::Parameters.new({})).permit(
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
