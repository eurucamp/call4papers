module ApplicationHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(:hard_wrap => true)
    markdown = Redcarpet::Markdown.new(renderer, :autolink => true, :space_after_headers => true, :fenced_code_blocks => true, :no_intra_emphasis => true)
    markdown.render(h(text)).html_safe
  end
end
