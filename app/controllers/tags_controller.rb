class TagsController < ApplicationController

  def show
    prepare_meta_tags(title: _tag.display_name)
  end

  private

  def _tag
    @_tag ||= Tag.find_by(permalink: params[:id])
  end
  helper_method :_tag

end
