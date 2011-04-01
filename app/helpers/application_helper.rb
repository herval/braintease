module ApplicationHelper

  def markdown(txt, options = {})
    raw = options.delete(:raw)
    body = render_page_links(txt.to_s, options)
    txt = if raw
      (defined?(RDiscount) ? RDiscount.new(body) : Maruku.new(body)).to_html
    else
      (defined?(RDiscount) ? RDiscount.new(body, :smart, :strict) : Maruku.new(sanitize(body))).to_html
    end

    if options[:sanitize] != false
      txt = defined?(Sanitize) ? Sanitize.clean(txt, SANITIZE_CONFIG) : sanitize(txt)
    end
    txt
  end
  
  # TODO devise?
  def logged_in?
    current_user?
  end
  
  def current_user?
    user_signed_in?
  end
  
  def twitter_login_button
    link_to(image_tag("/images/omnisocial/signin_twitter.png"), user_omniauth_authorize_path(:twitter))
  end

  def facebook_login_button
    link_to(image_tag("/images/omnisocial/signin_facebook.png"), user_omniauth_authorize_path(:facebook))
  end
  

  def render_page_links(text, options = {})
    in_controller = respond_to?(:logged_in?)

    text.gsub!(/\[\[([^\,\[\'\"]+)\]\]/) do |m|
      link = $1.split("|", 2)
      %@<a href="#{link.last}</a>@
    end

    return text if !in_controller

    text.gsub(/%(\S+)%/) do |m|
      case $1
        when 'site'
          group.domain
        when 'site_name'
          group.name
        when 'current_user'
          if logged_in?
            link_to(current_user.login, user_path(current_user))
          else
            "anonymous"
          end
        when 'hottest_today'
          question = Question.first(:activity_at.gt => Time.zone.now.yesterday, :order => "hotness desc, views_count asc", :group_id => group.id, :select => [:slug, :title])
          if question.present?
            link_to(question.title, question_path(question))
          end
        else
          m
      end
    end
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
        flash_text = content_tag('p', text.html_safe)
        messages << content_tag('li', flash_text.html_safe, :class => key)
      end

      out << content_tag('ul', messages.join("\n").html_safe, :class => "message "+key.to_s) unless messages.empty?
    end

    attrs = {:id => options[:id]} if options[:id]
    attrs[:class] = options[:class] if options[:class]
    return nil if out.empty?
    content_tag('div', out.join("\n").html_safe, attrs).html_safe
  end
end
