class Api::CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create

    @comment = Comment.new(comment_params)
    if @comment.save
      render json: {status: "SUCCESS", message: "comment was created successfully!", data: @comment}, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def comment_params
    params.permit(:feature_id, :body)
  end
end
