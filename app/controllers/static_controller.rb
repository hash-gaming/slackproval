require 'open-uri'

class StaticController < ApplicationController
  before_action :authentication_check, only: [:edit_code_of_conduct]
  def home
    render layout: "public"
  end

  def code_of_conduct
    url = URI.parse(ENV.fetch("CODE_OF_CONDUCT_LINK", ""))
    @code_of_conduct = ENV.fetch("CODE_OF_CONDUCT_LINK", "").blank? ? "" : open(url) { |io| data = io.read }
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true,
                                                                 tables: true,
                                                                 fenced_code_blocks: true,
                                                                 strikethrough: true,
                                                                 superscript: true,
                                                                 underline: true,
                                                                 highlight: true,
                                                                 quote: true,
                                                                 footnotes: true,
                                                                 with_toc_data: true,
                                                                 prettify: true,
                                                                 lax_spacing: true)
  end
end
