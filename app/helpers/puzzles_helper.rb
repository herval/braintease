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
  
  def microblogging_message(question)
    message = "#{h(question.title)}"
    message += " "
    message +=  escape_url(puzzle_path(question, :only_path =>false))
    message
  end

  def share_url(question, service)
    url = ""
    case service
      when :twitter
        if logged_in? && current_user.from_twitter?
          url = "http://twitter.com/?status=#{microblogging_message(question)}"
        end
      when :facebook
        fb_url = "http://www.facebook.com/sharer.php?u=#{escape_url(puzzle_path(question, :only_path =>false))}&t=#{question.title}"
        url = %@#{image_tag('/images/share/facebook_32.png', :class => 'microblogging')} #{link_to("facebook", fb_url, :rel=>"nofollow external")}@
    end
    url.html_safe
  end

  protected
  def escape_url(url)
    URI.escape(url, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
  end

end
