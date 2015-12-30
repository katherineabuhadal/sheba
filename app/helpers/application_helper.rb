module ApplicationHelper
  def pinterest_link(options = {})
    options[:url]   ||= request.original_url
    options[:media] ||= ''
    options[:description] ||= 'Sheba Yemeni Food'
    url = "//www.pinterest.com/pin/create/button/?"
    url << options.collect { |key, value| "#{key}=#{value}" }.join('&')
    link_to(image_tag("//assets.pinterest.com/images/pidgets/pinit_fg_en_rect_gray_20.png", { alt: 'Pin it'}), url, { 'data-pin-do' => "buttonPin", 'data-pin-config' => "beside" })
  end

end
