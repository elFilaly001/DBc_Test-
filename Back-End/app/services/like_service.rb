class LikeService
  def like_question(user, question)
    like = Like.where(user_id: user.id, question_id: question.id).first
    
    if like
      # If like exists, remove it (unlike)
      like.destroy
      { status: 'success', message: 'Question unliked successfully', liked: false, likes_count: question.likes.count }
    else
      # If like doesn't exist, create it
      like = Like.new(user_id: user.id, question_id: question.id)
      
      if like.save
        { status: 'success', message: 'Question liked successfully', liked: true, likes_count: question.likes.count }
      else
        { status: 'error', message: 'Failed to like question', errors: like.errors.full_messages }
      end
    end
  end
end