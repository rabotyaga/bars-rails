class PopulateArInfWoVowels < ActiveRecord::Migration
  def change
    Article.all.each do |a|
        a.update!({ :ar_inf_wo_vowels => a.ar_inf.gsub(/[\u064b\u064c\u064d\u064e\u064f\u0650\u0651\u0652\u0653\u0670]/,'')})
    end
  end
end
