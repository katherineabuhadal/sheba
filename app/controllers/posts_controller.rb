class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :create, :update]
  before_action :find_post, only: [:show]

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

  private

  def find_post
    redirect_to root_path, status: 301 unless post.present?
  end

  def posts
    @_posts ||= Post.published.ordered.paginate(page: params[:page], per_page: 10)
  end
  helper_method :posts

  def post_params
    (params[:recipe] || ActionController::Parameters.new({})).permit(
      :title,
      :content,
      :published_at,
      :published,
      :external_link,
      :style,
      :tag_list,
      :ingredients,
      :permalink
    )
  end

  def comment
    @_comment ||= post.comments.new
  end
  helper_method :comment

  def reply
    @_reply ||= post.comments.new
  end
  helper_method :reply

  def create_post_pictures
    return unless params[:images]
    params[:images].each do |image|
      post.pictures.create(image: image)
    end
  end
end
