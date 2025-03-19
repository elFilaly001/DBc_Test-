class LikeController < ApplicationController
  before_action :authenticate_request
  
  def toggle_like
    if params[:question_id].blank?
      render json: { status: 'error', message: 'Question ID is required' }, status: :bad_request
      return
    end

    question = Question.find_by(id: params[:question_id])
    
    if question.nil?
      render json: { status: 'error', message: 'Question not found' }, status: :not_found
      return
    end
    
    like_service = LikeService.new
    result = like_service.like_question(@current_user, question)
    
    if result[:status] == 'success'
      render json: result, status: :ok
    else
      render json: result, status: :unprocessable_entity
    end
  end
end
