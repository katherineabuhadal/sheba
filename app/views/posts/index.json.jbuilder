json.array!(@posts) do |post|
  json.extract! post, :id, :title, :content, :published_at, :published, :external_link, :style, :permalink
  json.url post_url(post, format: :json)
end
