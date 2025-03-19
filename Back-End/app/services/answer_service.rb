class AnswerService
  def self.create_answer(params , user , question)
    answer = Answer.new(user: user._id , question: question._id , content: params[:content])
    if answer.save
      return {status: 'success', answer: answer}
    else
      return {status: 'error', message: answer.errors.full_messages.join(': ')}
    end
  end
end