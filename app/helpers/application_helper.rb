module ApplicationHelper
  def format_date(date)
    l(date, format: '%b %-d, %Y')
  end

  def format_time(time)
    l(time, format: '%-d %B %Y, %H:%M')
  end

  def tag_cloud(tags, css_classes)
    max = tags.sort_by(&:count).last

    tags.each do |tag|
      index = tag.count / max.count.to_f * (css_classes.size - 1)
      yield(tag, css_classes[index.round])
    end
  end

  def markdown(text)
    options = {
      filter_html: true,
      hard_wrap: true,
      link_attributes: { rel: 'nofollow', target: '_blank' },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink: true,
      superscript: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end

  def get_flash_class(flash_type)
    { success: 'alert-success', error: 'alert-error', alert: 'alert-warning', notice: 'alert-info' }[flash_type.to_sym] || flash_type.to_s
  end
end
