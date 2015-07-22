class FirstLetter < ActiveRecord::Base
  default_scope { order(:id) }

  has_many :articles
end
