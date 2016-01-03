class RecipesController < ApplicationController

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if recipe.save
      create_recipe_pictures
      message(:notice, :saved)
    end
    respond_with recipe
  end

  def update
    message(:notice, :updated) if recipe.update_attributes(recipe_params)
    respond_with recipe
  end

  private

  def recipe
    @_recipe ||= params[:id] ? Recipe.find_by(permalink: params[:id]) : Recipe.new(recipe_params)
  end
  helper_method :recipe

  def recipes
    @_recipes ||= Recipe.published.ordered.paginate(page: params[:page], per_page: 10)
  end
  helper_method :recipes

  def recipe_params
    (params[:recipe] || ActionController::Parameters.new({})).permit(
      :title,
      :content,
      :published_at,
      :published,
      :external_link,
      :style,
      :permalink
    )
  end

  def comment
    @_comment ||= recipe.comments.new
  end
  helper_method :comment

  def create_recipe_pictures
    return unless params[:images]
    params[:images].each do |image|
      recipe.pictures.create(image: image)
    end
  end
end
