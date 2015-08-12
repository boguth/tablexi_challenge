class TextFileController < ApplicationController
  def index
    @error = nil
  end

  def upload
    uploaded_file = params[:text_file].read
    @text_file = TextFile.new
    if uploaded_file != nil && @text_file.correct_formatting?(uploaded_file)
      @text_file.menu_items_array = uploaded_file
      @text_file.solve
    else
      @error = "Something went wrong. Either the file you uploaded wasn't formatted properly or you failed to upload a file at all."
      render :index
    end
  end
end
