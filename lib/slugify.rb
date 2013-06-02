module Slugify
  def create_slug
    if slug_base
      self.slug = self.send(slug_base).parameterize
    end
  end

  def slug_base
    if self.class == Bulletin
      slug_base = "title"
    elsif self.class == Organization
      slug_base = "display_name"
    end
  end
end