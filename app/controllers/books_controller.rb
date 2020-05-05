class BooksController < ApplicationController
  # show, edit, update and destroy all need a common @book object to work with, so find it first...
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # instead of all books, we are only getting a list of published books
  def index
    @books = Book.published.by_title.paginate(:page => params[:page]).per_page(10)
  end
  
  # this is special action we've created to give us list of proposed books
  def proposed
    @books = Book.proposed.by_category.paginate(:page => params[:page]).per_page(10)
  end
  
  # this is special action we've created to give us list of books under contract
  def contracted
    @books = Book.under_contract.by_category.paginate(:page => params[:page]).per_page(10)
  end

  def show
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book, notice: "#{@book.title} was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: "#{@book.title} was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from users (potential hackers), but rather only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :category_id, :units_sold, :proposal_date, :contract_date, :published_date, :notes, :author_ids => [])
    end
end
