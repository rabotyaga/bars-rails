class TextInput < SimpleForm::Inputs::TextInput
  def input_html_classes
    super.push('span6')
  end
  def input_html_options
    { :rows => 5 }.merge(super)
  end
end