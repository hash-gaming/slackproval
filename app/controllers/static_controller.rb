class StaticController < ApplicationController
  before_action :authentication_check, only: [:edit_code_of_conduct]
  def home

  end

  def code_of_conduct
    if File.exists?('CODE_OF_CONDUCT.md')
      @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    else
      File.open("CODE_OF_CONDUCT.md", "w") {}
    end
  end

  def edit_code_of_conduct
  end

  def update_code_of_conduct
    File.open("CODE_OF_CONDUCT.md", "w") { |file| file.write(params[:content]) }
    redirect_to code_of_conduct_path
  end
end
