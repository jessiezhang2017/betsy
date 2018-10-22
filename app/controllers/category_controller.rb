class CategoryController < ApplicationController

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:name])
    if @category.save
      flash[:success] = "Successfully created #{@category.name}!"

      redirect_to category_path(id: @categpru.id)
    else
      flash.now[:warning] = "Category is not created!"
      @categpru.errors.messages.each do |field, messages|
      flash.now[field] = messages
      end
    end

    render :new
  end
end
