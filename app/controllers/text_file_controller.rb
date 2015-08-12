class TextFileController < ApplicationController
  def index
    @error = nil
  end

  def upload
  uploaded_file = params[:text_file]
    if uploaded_file != nil # If it's empty, we're just going to re render the index page with an error message. If it's not then we continue on.
      uploaded_file = uploaded_file.read
      @text_file = TextFile.new
      if @text_file.correct_formatting?(uploaded_file) #This checks to make sure that whatever is being passed in is formatted like the initial example.
        @text_file.menu_items_array = uploaded_file # This populates a variable that stores each of the lines in the txt file. Right now it's storing
                                                    # a String, but we're going to change that to an array on the very next step.
                                                    # Hence the variable name "menu_items_array"
        @text_file.solve # This is essentially the runner. It kicks off a series of steps that determines possible solutions and formats them.
      else # If the file wasn't formatted correctly, we re-render the page with an error message.
        @error = "Something went wrong, which means either I messed up or you did. But that's okay! We can try again! Make sure that the file you're trying to upload is in the right format."
        render :index
      end
    else
      @error = "Something went wrong, which means either I messed up or you did. But that's okay! We can try again! Make sure that the file you're trying to upload is in the right format."
      render :index
    end
  end
end
