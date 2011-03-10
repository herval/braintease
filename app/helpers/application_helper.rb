module ApplicationHelper
  
  # TODO devise?
  def logged_in?
    true
  end
  
  def current_user
    User.new
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

      out << content_tag('ul', messages.join("\n"), :class => "message "+key.to_s) unless messages.empty?
    end

    attrs = {:id => options[:id]} if options[:id]
    attrs[:class] = options[:class] if options[:class]
    return nil if out.empty?
    content_tag('div', out.join("\n"), attrs)
  end
end
