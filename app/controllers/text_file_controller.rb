class TextFileController < ApplicationController
  def index

  end

  def upload
    uploaded_file = params[:text_file]
    if uploaded_file == nil
      render :index
    else
      @text_file = TextFile.new
      @text_file.menu_items_array = uploaded_file.read
      @text_file.solve
    end
  end
end
