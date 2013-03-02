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

  def gravatar_avatar_url(user, size)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end

  def twitter_avatar_url(handle)
    "https://twitter.com/api/users/profile_image/#{handle}?size=bigger"
  end

  def avatar_url(user, size = 64)
    return twitter_avatar_url(user.twitter_handle) if user.twitter_handle
    gravatar_avatar_url(user, size)
  end
end
