class TextFileController < ApplicationController
  def index

  end

  def upload
    uploaded_file = params[:text_file]
    @text_file = TextFile.new
    @text_file.menu_items_array = uploaded_file.read
    @text_file.answer = @text_file.solve
    @text_file.target_price = @text_file.target
  end
end
