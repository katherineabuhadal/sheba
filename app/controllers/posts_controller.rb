class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :create, :update, :new]
  before_action :find_post, only: [:show]

  def index
    prepare_meta_tags title: "Recipes"
  end

  def show
    prepare_meta_tags(title: post.title,
                      description: post.content,
                      keywords: post.tags.pluck(:name).take(5),
                      image: post.primary_image,
                      twitter: {card: "summary_large_image"})
  end

  def create
    if post.save
      create_post_pictures
      message(:notice, :saved)
    end
    respond_with post
  end


  def new
  end

  def edit
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
    @_posts ||= Post.published.ordered.search(params).paginate(page: params[:page], per_page: 10)
  end
  helper_method :posts

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
