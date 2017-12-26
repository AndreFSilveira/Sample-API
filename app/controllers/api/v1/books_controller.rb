module API::V1
  class BooksController < ApplicationController
    before_action :set_book, only: [:show, :update, :destroy]
    before_action :check_filter, only: [:index]

    # GET /books
    def index
      if name = params[:name]
        @books = @books.where('name LIKE ?', "%#{name}%")
      end
      paginate json: @books, status: 200, per_page: params[:per_page] || 10
    end

    # GET /books/1
    def show
      render json: @book, status: 200
    end

    # POST /books
    def create
      @book = Book.new(book_params)

      if @book.save
        render json: @book, status: :created, location: api_v1_book_url(@book)
      else
        render json: @book.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /books/1
    def update
      if @book.update(book_params)
        render json: @book
      else
        render json: @book.errors, status: :unprocessable_entity
      end
    end

    # DELETE /books/1
    def destroy
      @book.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def book_params
      params.require(:book).permit(:name, :pages, :leased, :year)
    end

    def check_filter
      if params[:writer_id].present? && (writer = Writer.find(params[:writer_id]))
        @books = writer.books
      elsif params[:customer_id].present? && (customer = Customer.find(params[:customer_id]))
        @books = customer.books
      else
        @books = Book.all
      end
    end
  end
end
