class NController < ApplicationController
  def show
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    @bulletin = Bulletin.where(slug: params[:id]).first
  end
end