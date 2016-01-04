module Permalinkable

  def to_param
    respond_to?(:permalink) ? permalink : name.downcase
  end

end
