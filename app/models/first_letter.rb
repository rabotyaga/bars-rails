# frozen_string_literal: true

class FirstLetter < ApplicationRecord
  default_scope { order(:id) }

  has_many :articles
end
