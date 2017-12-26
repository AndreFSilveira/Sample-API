module API::V1
  class WritersController < ApplicationController
    before_action :set_writer, only: %i[show update destroy]
    before_action :check_book_filter, only: [:index]

    # GET /writers
    def index
      paginate json: @writers, status: 200, per_page: params[:per_page] || 10
    end

    # GET /writers/1
    def show
      render json: @writer
    end

    # POST /writers
    def create
      @writer = Writer.new(writer_params)

      if @writer.save
        render json: @writer, status: :created, location: api_v1_writer_url(@writer)
      else
        render json: @writer.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /writers/1
    def update
      if @writer.update(writer_params)
        render json: @writer
      else
        render json: @writer.errors, status: :unprocessable_entity
      end
    end

    # DELETE /writers/1
    def destroy
      @writer.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_writer
      @writer = Writer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def writer_params
      params.require(:writer).permit(:name, :city, :dob)
    end

    def check_book_filter
      @writers = if params[:book_id].present? && (book = Book.find(params[:book_id]))
                   book.writers
                 else
                   Writer.all
                 end
    end
  end
end
