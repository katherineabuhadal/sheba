module ApplicationHelper
  def pinterest_link(options = {})
    options[:url]   ||= request.original_url
    options[:media] ||= ''
    options[:description] ||= 'Sheba Yemeni Food'
    url = "//www.pinterest.com/pin/create/button/?"
    url << options.collect { |key, value| "#{key}=#{value.to_s.force_encoding("UTF-8")}" }.join('&')
    link_to(image_tag("//assets.pinterest.com/images/pidgets/pinit_fg_en_rect_gray_20.png", { alt: 'Pin it'}), url, { 'data-pin-do' => "buttonPin", 'data-pin-config' => "beside" })
  end

  def facebook_link(options = {})
    options[:url] ||= 'www.shebayemenifood.com'
    url = options[:url]
    # url << options.collect { |key, value| "#{key}=#{value}" }.join('&')
    raw "<div class='fb-like' data-href=#{url} data-layout='button_count' data-action='like' data-show-faces='false' data-share='false'></div>"
  end

  def image_link(post)
    return unless post.primary_image
    post.primary_image.url
  end

end
