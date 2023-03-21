class AuthorsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  
  def show
    author = Author.find(params[:id])

    render json: author
  end

  def create
    author = Author.create!(author_params)

    render json: author, status: :created
  end

  private
  
  def author_params
    params.permit(:email, :name)
  end

  def render_unprocessable_entity_response ( author )
    # render json: { errors: author.record.errors.full_messages }, status: 422
    render json: { errors: author.record.errors.messages }, status: 422
  end
  
end
