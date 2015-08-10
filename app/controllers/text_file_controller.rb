class TextFileController < ApplicationController
  def index
    @text_file = TextFile.new
  end

  def create
    # post = DataFile.save(params[:upload])
    # render :text => "File has been uploaded successfully"
  end

  def upload
    uploaded_file = params[:text_file]
    file_content = uploaded_file.read
    puts file_content
  end
end
