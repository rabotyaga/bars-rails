# frozen_string_literal: true

class NumericInput < SimpleForm::Inputs::NumericInput
  def input_html_classes
    super.push('span4')
  end
end
