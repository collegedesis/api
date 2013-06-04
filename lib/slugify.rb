module Slugify
  def create_slug
    self.slug = self.send(slug_base).parameterize if slug_base
  end

  def slug_base
    if self.class == Bulletin
      slug_base = "title"
    elsif self.class == Organization
      slug_base = "display_name"
    end
  end
end