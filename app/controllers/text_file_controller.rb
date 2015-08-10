class TextFileController < ApplicationController
  def index
    @text_file = TextFile.first
  end

  def create
    # post = DataFile.save(params[:upload])
    # render :text => "File has been uploaded successfully"
  end

  def upload
    puts params
    puts "HERE WE ARE"
  end
end
