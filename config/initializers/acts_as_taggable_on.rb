ActsAsTaggableOn::Tag.class_eval do
  before_save { |tag| tag.permalink = name.parameterize if name_changed? }
end
