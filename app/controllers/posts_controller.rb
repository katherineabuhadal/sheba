class PostsController < ApplicationController

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if post.save
      create_post_pictures
      message(:notice, :saved)
    end
    respond_with post
  end

  def update
    message(:notice, :updated) if post.update_attributes(post_params)
    respond_with post
  end

  def destroy
    post.destroy
    respond_with post
  end

  private

  def post
    @_post ||= params[:id] ? Post.find(params[:id]) : Post.new(post_params)
  end
  helper_method :post

  def posts
    @_posts ||= Post.published.ordered.paginate(page: params[:page], per_page: 12)
  end
  helper_method :posts

  def post_params
    (params[:post] || ActionController::Parameters.new({})).permit(
      :title,
      :content,
      :published_at,
      :published,
      :external_link,
      :style,
      :permalink
    )
  end

  def create_post_pictures
    return unless params[:images]
    params[:images].each do |image|
      post.pictures.create(image: image)
    end
  end
end
