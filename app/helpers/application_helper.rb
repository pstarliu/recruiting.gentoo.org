require 'html_with_pygments'
module ApplicationHelper
  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
     # Skip Devise :timeout and :timedout flags
     next if type == :timeout
     next if type == :timedout
     type = :success if type == :notice
     type = :error if type == :alert
     text = content_tag(:div,
              content_tag(:button, raw("&times;"), :class => "close", "data-dismiss" => "alert") +
              message, :class => "alert fade in alert-#{type}")
     flash_messages << text if message
    end
    flash_messages.join("\n").html_safe
  end

  def flash_block
    output = ''
    flash.each do |type, message|
      output += flash_container(type, message)
    end

    raw(output)
  end

  def flash_container(type, message)
    raw(content_tag(:div, :class => "alert alert-#{type}") do
      content_tag(:a, raw("&times;"),:class => 'close', :data => {:dismiss => 'alert'}) +
      message
    end)
  end

  # ==== Examples
  # glyph(:share_alt)
  # # => <i class="icon-share-alt"></i>
  # glyph(:lock, :white)
  # # => <i class="icon-lock icon-white"></i>
  def glyph(*names)
    content_tag :i, nil, :class => names.map{|name| "icon-#{name.to_s.gsub('_','-')}" }
  end

  def render_breadcrumbs(divider = '/')
    render :partial => 'shared/breadcrumbs', :locals => { :divider => divider }
  end

  def markdown(text)
    return "" if text.nil?
    @markdown ||= Redcarpet::Markdown.new(HtmlWithPygments.new(filter_html: true),
        autolink: false, space_after_headers: true, fenced_code_blocks: true)
    @markdown.render(text).html_safe
  end

  def project_page(p)
    host = "http://www.gentoo.org"
    if p.homepage.nil?
      p.name
    else
      link_to p.name, host + p.homepage
    end
  end

  def progress_bar(value)
    content_tag :div, class: :progress do
      content_tag :div, "#{value}%", style: "width: #{value}%", class: "progress-bar progress-bar-success", role: "progressbar", "aria-valuenow" => value, "aria-valuemin" => 0, "aria-valuemax" => 1
    end
  end
  
  def answer_status(answer)
    if answer.nil?
      content_tag :div, "Unanswered", class: "label label-warning"
    elsif answer.awaiting_review?
      content_tag :div, "Awaiting review", class: "label label-info"
    elsif answer.rejected?
      content_tag :div, "Rejected by #{unsluggish_name(answer.operator.name) rescue nil}", class: "label label-danger"
    else
      content_tag :div, "Accepted by #{unsluggish_name(answer.operator.name) rescue nil}", class: "label label-success"
    end
  end

  def unsluggish_name(name)
    name.gsub("-", ' ').titleize
  end

  def current_entry_info(idx, page, per_page = 25)
    '%02d' % (idx + (per_page * ((page.try(:to_i) || 1) - 1)) + 1)
  end
end
