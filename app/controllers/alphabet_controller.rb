# frozen_string_literal: true

class AlphabetController < ApplicationController
  def index
    @alphabet = Alphabet.all
  end
end
