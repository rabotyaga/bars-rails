class AlphabetController < ApplicationController
  def index
    @alphabet = Alphabet.all
  end
end
