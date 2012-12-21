module ApplicationHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(:hard_wrap => true)
    markdown = Redcarpet::Markdown.new(renderer, :autolink => true, :space_after_headers => true, :fenced_code_blocks => true, :no_intra_emphasis => true)
    markdown.render(h(text)).html_safe
  end

  def twitter_link(handle)
    handle = h(handle.to_s.sub(/\A@/, ''))
    link_to(truncate(handle, length: 20), "http://twitter.com/#{handle}") unless handle.blank?
  end

  def github_link(handle)
    handle = h(handle.to_s.sub(/\A@/, ''))
    link_to(truncate(handle, length: 20), "http://github.com/#{handle}") unless handle.blank?
  end
end
