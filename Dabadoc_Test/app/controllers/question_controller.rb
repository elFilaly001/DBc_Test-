class QuestionController < ApplicationController

    skip_before_action :verify_authenticity_token
    
    def index
        questions = Question.all
        render json: questions
    end

    def create
        question = Question.create(question_params)
        if question.save
            render json: question, status: :created
        else
            render json: { errors: question.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        question = Question.find(params[:id])
        question.update(question_params)
        render json: question
    end

    def destroy
        question = Question.find(params[:id])
        question.destroy
        head :no_content
    end 

    private

    def question_params
        params.require(:question).permit(:title, :content, :location)
    end
end
