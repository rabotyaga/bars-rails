# frozen_string_literal: true

class StringInput < SimpleForm::Inputs::StringInput
  def input_html_classes
    super.push('span4')
  end
end
