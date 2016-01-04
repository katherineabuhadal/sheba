class ContentController < PostsController

  private

  def post
    @_post ||= Content.find_by(permalink: params[:id])
  end
  helper_method :post
end
