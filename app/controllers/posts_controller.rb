class PostsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  #need bang operateors in creat and update if you are using the above

  def show
    post = Post.find(params[:id])
    
    render json: post
  end

  def update
    post = Post.find(params[:id])
    post.update!(post_params)
    if post
      render json: post
    else 
      render json: {error: "post not found" }, status: :not_found  
    end
  end

  private

  def post_params
    params.permit(:category, :content, :title)
  end

  def render_not_found_response
    render json: { errors: ['Post was not found.']}, status: 404
  end

  def render_unprocessable_entity_response ( post )
    # render json: { errors: author.record.errors.full_messages }, status: 422
    render json: { errors: post.record.errors.messages }, status: 422
  end

end
