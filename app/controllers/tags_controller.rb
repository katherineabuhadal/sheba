class TagsController < ApplicationController
  before_action :find_tag, only: [:show]

  def show
    prepare_meta_tags(title: _tag.display_name)
  end

  private

  def find_tag
    redirect_to root_path, status: 301 unless _tag.present?
  end

  def _tag
    @_tag ||= Tag.find_by(permalink: params[:id])
  end
  helper_method :_tag

end
