class TextFileController < ApplicationController
  def index
    @text_file = TextFile.new
  end


  def upload
    uploaded_file = params[:text_file]
    @text_file = TextFile.new(uploaded_file)
    @text_file.solve
  end
end
