class DrupalImporter
  def initialize(node, field_data_body, ingredients)
    @node = node
    @field_data_body = field_data_body
    @ingredients = ingredients
  end

  def run
    @node = initialize_recipe
  end

  def initialize_recipe
    @recipe = Recipe.create(
      title: title,
      content: content,
      created_at: created_at,
      updated_at: updated_at,
      ingredients: ingredients,
      permalink: permalink,
      published: true,
    )

    if image_path
      picture = @recipe.pictures.create(name: "xyz")
      picture.image = File.new(image_path)
      picture.save
    end
    find_comments
    create_taggings
    create_video
  end

  private

  def image_path
    image = Drupal::RecipeImage.where(entity_id: @node.nid).first
    if image
      path = Drupal::FileManaged.where(fid: image.field__recipeimage_fid).first
      path.uri.gsub("public:/", "").prepend("docroot/sites/default/files")
    else
      return nil
    end
  end

  def title
    @node.title
  end

  def content
    return unless @field_data_body
    @field_data_body.body_value
      .gsub(/<script.*?script>/m, '')
      .gsub(/<style.*?style>/m, '')
      .gsub(/<.*?>/m, '')
      .gsub(/&.*?;/, '')
      .gsub(/[\r\n]+/, "\n")
  end

  def created_at
    Time.at(@node.created).to_datetime
  end

  def updated_at
    Time.at(@node.read_attribute(:changed)).to_datetime
  end

  def ingredients
    return unless @ingredients
    @ingredients.field_ingredients_value
  end

  def permalink
    url_alias = Drupal::UrlAlias.where(source: "node/#{@node.id}").first.alias
    url_alias.gsub("content/", "")
  end

  def parent_comments
    Drupal::Comment.where(nid: @node.nid, pid: 0)
  end

  def comment_subject(comment)
    Drupal::CommentBody.where(entity_id: comment.id).first
  end

  def create_comment(comment, parent_comment = nil)
    Comment.create(
      post_id: @recipe.id,
      content: (comment_subject(comment).comment_body_value if comment_subject(comment)),
      title: comment.subject,
      name: comment.name,
      created_at: Time.at(comment.created).to_datetime,
      parent_id: (parent_comment.id if comment.pid != 0),
    )
  end

  def find_comments
    parent_comments.each do |comment|
      new_parent_comment = create_comment(comment)
      children = Drupal::Comment.where(pid: comment.id)

      children.each do |child|
        create_comment(child, new_parent_comment)
      end
    end
  end

  def create_taggings
    taggings = Drupal::Tagging.where(nid: @node.id)
    taggings.each do |tagging|
      drupal_tag = Drupal::Tag.find_by(tid: tagging.tid)
      category = Category.find_or_create_by(name: Drupal::Category.find_by(vid: drupal_tag.vid).name)
      tag = Tag.find_or_create_by(name: drupal_tag.name.downcase, category: category)
      @recipe.taggings.create(tag: tag)
    end
  end

  def video
    Drupal::Video.where(entity_id: @node.id).first
  end

  def create_video
    return unless video
    VideoLink.create(english_link: video.field_video_value, post: @recipe)
  end

end
