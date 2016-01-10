class TagsController < ApplicationController

  def show
  end

  private

  def _tag
    @_tag ||= Tag.find_by(name: params[:id])
  end
  helper_method :_tag

end
