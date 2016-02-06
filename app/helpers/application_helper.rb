module ApplicationHelper
  def flash_class(level)
    case level
    when :notice then return 'alert alert-info'
    when :success then return 'alert alert-success'
    when :error then return 'alert alert-danger'
    when :alert then return 'alert alert-warning'
    end
  end

  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end
end
