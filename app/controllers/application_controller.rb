class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :prepare_meta_tags, if: "request.get?"

  respond_to :html

  def message(notice, action)
    flash[:notice] = "Your entry has been saved"
  end

  def prepare_meta_tags(options={})
    site_name   = "Sheba Yemeni Food"
    title       = options[:title] ||= [controller_name, action_name].join(" ")
    description = options[:description] ||= "My name is Katherine, and I am on a journey to discover Yemeni cooking. Join me!"
    image       = options[:image] || ActionController::Base.helpers.asset_path("sheba-yemeni-food-logo.png")
    keywords    = options[:keywords] || %w[yemeni recipes cooking food arabic]
    current_url = request.url.force_encoding("UTF-8")

    defaults = {
      site:        site_name,
      title:       title,
      image:       image,
      description: description,
      keywords:    keywords,
      og: {
        url: current_url,
        site_name: site_name,
        title: title,
        image: image,
        description: description,
        type: 'website'
      },
      twitter: {
        site_name: site_name,
        description: description,
        image: image
      },
    }

    options.reverse_merge!(defaults)

    set_meta_tags options
  end
end
