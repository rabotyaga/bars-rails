class Alphabet < ActiveRecord::Base
  default_scope{ order(:nr) }

  def in_the_beginning
    self.letter + "\u0640"
  end

  def in_the_middle
    "\u0640" + self.letter + "\u0640"
  end

  def in_the_end
    "\u0640" + self.letter
  end
end
