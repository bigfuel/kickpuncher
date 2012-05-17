class Responders < ActionController::Responder
  def to_format
    unless @resource
      render "/not_found", status: :not_found
    end

    case
    when get?

    when has_errors?
      controller.response.status = :unprocessable_entity
    when post?
      controller.response.status = :created
    when put?
      render "show", status: :ok
    when delete?
      render "/delete", status: :ok
    end

    # default_render
  rescue ActionView::MissingTemplate => e
    api_behavior(e)
  end
end