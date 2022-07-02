class ApplicationResponder < ActionController::Responder
  include Responders::FlashResponder
  include Responders::HttpCacheResponder

  # Redirects resources to the collection path (index action) instead
  # of the resource path (show action) for POST/PUT/DELETE requests.
  # include Responders::CollectionResponder

  def to_json(*_args)
    set_flash_message! if set_flash_message?
    to_format
  end

  def set_flash_message!
    @alert ||= controller.flash.alert
    @notice ||= controller.flash.notice
    controller.flash.clear
    super
  end

  def set_flash_now?
    true
  end

  def to_format
    if has_errors? && !response_overridden?
      display_errors
    elsif has_view_rendering? || response_overridden?
      default_render
    else
      api_behavior
    end
  end

  def json_resource_errors
    errors = resource.errors.as_json.reduce({}) { |h, (k, v)| k.to_s.include?('.') ? h : h.merge!(k => v.first) }

    errors[:base] ||= resource.errors.full_messages.first.humanize

    { errors: }
  end
end
