class DController < ApplicationController
  def show
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    @organization = Organization.where(slug: params[:id]).first
  end
end