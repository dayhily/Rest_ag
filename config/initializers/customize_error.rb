ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  if html_tag =~ /\<label/
    html_tag
  else
    errors = Array(instance.error_message).join(',')
    %(#{html_tag}<span class="validation-error">&nbsp;#{errors}</span>).html_safe
  end
end