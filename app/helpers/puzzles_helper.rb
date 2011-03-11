module PuzzlesHelper

  def class_for_puzzle(question)
    klass = ""

    # if question.accepted
    #   klass << "accepted"
    if question.answered?
      klass << "unanswered"
    else
      klass << "accepted"
    end

    if logged_in?
      # if current_user.is_preferred_tag?(current_group, *question.tags)
      #   klass << " highlight"
      # end

      if current_user == question.user
        klass << " own_question"
      end
    end

    klass
  end

end
