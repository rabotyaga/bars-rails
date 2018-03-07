# frozen_string_literal: true

json.array!(@articles) do |article|
  json.extract! article, :nr, :ar_inf, :form, :opt, :mn1, :ar1, :mn2, :ar2, :mn3, :ar3, :translation, :notes
end
