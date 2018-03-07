# frozen_string_literal: true

class AddArInfWoVowelsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :ar_inf_wo_vowels, :string
  end

  def up
    Article.all.each do |a|
      a.update(ar_inf_wo_vowels: a.ar_inf.gsub(/[\u064b\u064c\u064d\u064e\u064f\u0650\u0651\u0652\u0653\u0670]/, ''))
    end
  end
end
