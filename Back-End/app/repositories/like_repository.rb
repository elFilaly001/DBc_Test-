class LikeRepository
  def self.Like_Question(user:, question:)
    if user.nil?
      return {status: 'error', message: 'User not found'}
    end

    if question.nil?
      return {status: 'error', message: 'Question not found'}
    end

    like = Like.new(user: user, question: question)
    if like.save
      return {status: 'success', like: like}
    else
      return {status: 'error', message: like.errors.full_messages.join(', ')}
    end
  end

  def self.find_like(user, question)
    if user.nil?
      return {status: 'error', message: 'User not found'}
    end

    if question.nil?
      return {status: 'error', message: 'Question not found'}
    end

    like = Like.find_by(user: user, question: question)
    if like.nil?
      return false
    else
      return true
    end
  end

  def self.Unlike_Question(user:, question:)
    if user.nil?
      return {status: 'error', message: 'User not found'}
    end

    if question.nil?
      return {status: 'error', message: 'Question not found'}
    end

    like = Like.find_by(user: user, question: question)
    if like.nil?
      return {status: 'error', message: 'Like not found'}
    end

    if like.destroy
      return {status: 'success', message: 'Like removed successfully'}
    else
      return {status: 'error', message: like.errors.full_messages.join(', ')}
    end
  end
end