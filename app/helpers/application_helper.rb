module ApplicationHelper
  
  # TODO devise?
  def logged_in?
    current_user?
  end
  
  def class_for_puzzle(question)
    klass = ""

    if question.accepted
      klass << "accepted"
    elsif !question.answered
      klass << "unanswered"
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

  def class_for_number(number)
    if number >= 1000 && number < 10000
      "medium_number"
    elsif number >= 10000
      "big_number"
    elsif number < 0
      "negative_number"
    end
  end

  def format_number(number)
    if number < 1000
      number.to_s
    elsif number >= 1000 && number < 1000000
      "%.01fK" % (number/1000.0)
    elsif number >= 1000000
      "%.01fM" % (number/1000000.0)
    end
  end
      
  def show_flash_messages(options={})
    options = { :keys => [:warning, :notice, :message, :error],
                :id => 'messages',
                :textilize => false,
                :markdown => false}.merge(options)
    out = []
    options[:keys].each do |key|
      next unless flash[key]
      messages = []
      [flash[key]].flatten.compact.each do |msg|
        text = msg
        if options[:markdown]
          text = markdown(msg)
        elsif options[:textilize]
          text = textilize(msg)
        end
        flash_text = content_tag('p', text)
        messages << content_tag('li', flash_text, :class => key)
      end

      out << raw(content_tag('ul', messages.join("\n"), :class => "message "+key.to_s)) unless messages.empty?
    end

    attrs = {:id => options[:id]} if options[:id]
    attrs[:class] = options[:class] if options[:class]
    return nil if out.empty?
    content_tag('div', out.join("\n"), attrs)
  end
end
