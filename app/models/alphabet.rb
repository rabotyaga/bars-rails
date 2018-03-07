# frozen_string_literal: true

class Alphabet < ApplicationRecord
  default_scope { order(:nr) }

  def in_the_beginning
    letter + "\u0640"
  end

  def in_the_middle
    "\u0640" + letter + "\u0640"
  end

  def in_the_end
    "\u0640" + letter
  end
end
