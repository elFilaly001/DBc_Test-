class AnswerController < ApplicationController

    def add_answer
        # Extract and validate question_id from params
        question_id = params[:question_id] || (params[:answer] && params[:answer][:question_id])
        content = params[:content] || (params[:answer] && params[:answer][:content])
        
        if question_id.nil?
            render json: { status: 'error', message: 'Question ID is required' }, status: :unprocessable_entity
            return
        end
        
        if content.nil?
            render json: { status: 'error', message: 'Content is required' }, status: :unprocessable_entity
            return
        end
        
        answer = AnswerRepository.add_answer(@current_user, question_id, content)
        if answer[:status] == 'success'
            render json: { status: 'success', message: 'Answer created successfully', answer: answer[:answer] }, status: :created
        else
            render json: { status: 'error', message: answer[:message] }, status: :unprocessable_entity
        end
    end

    private

    def answer_params
        params.require(:answer).permit(:content)
    end
end
