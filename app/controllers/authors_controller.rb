class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  def index
    @authors = Author.active.alphabetical.paginate(page: params[:page]).per_page(10)
  end

  def show
  end

  def edit
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
    if @author.save
        redirect_to author_path(@author), notice: "#{@author.name} was added to the system."
    else
        render action: 'new'
    end
  end

  def update
      if @author.update(author_params)
          redirect_to author_path(@author), notice: "#{@author.name} was revised in the system."
      else
          render action: 'edit'
      end
  end

  def destroy
    @author.destroy
    redirect_to authors_path
  end

  private
  def author_params
    params.require(:author).permit(:first_name, :last_name, :active)
  end

  def set_author
    @author = Author.find(params[:id])
  end
end
  