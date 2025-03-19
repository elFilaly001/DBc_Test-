class AnswerRepository
    def self.add_answer(user, question_id, content)
        if user.nil?
            return {status: 'error', message: 'User not found'}
        end

        if question_id.nil?
            return {status: 'error', message: 'Question ID is required'}
        end

        begin
            question = Question.find(question_id) 
        rescue Mongoid::Errors::DocumentNotFound
            return {status: 'error', message: 'Question not found'}
        end

        answer = Answer.new(user: user, question: question, content: content)
        if answer.save
            return {status: 'success', answer: answer}
        else
            return {status: 'error', message: answer.errors.full_messages.join(', ')}
        end
    end
end