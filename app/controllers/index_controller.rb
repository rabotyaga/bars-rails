# frozen_string_literal: true

class IndexController < ApplicationController
  def index; end

  def search
    req = if params[:input_lang] == 'ru'
            'translation '
          else
            'ar_inf_wo_vowels_n_hamza '
          end

    if params[:search_type] == 'exact'
      if params[:input_lang] == 'ru'
        req += '= :p1 OR translation LIKE :p2 OR translation LIKE :p3 OR translation LIKE :p4 OR translation LIKE :p5 OR translation LIKE :p6 OR translation LIKE :p7 OR translation LIKE :p8'
        param = { p1: params[:q], p2: "#{params[:q]} %", p3: "% #{params[:q]}", p4: "% #{params[:q]};%", p5: "% #{params[:q]} %", p6: "% #{params[:q]}!%", p7: "% #{params[:q]}.%", p8: "% #{params[:q]},%" }
      else
        req += '= :p1 OR ar123_wo_vowels_n_hamza = :p1 OR ar123_wo_vowels_n_hamza LIKE :p2 OR ar123_wo_vowels_n_hamza LIKE :p3 OR ar123_wo_vowels_n_hamza LIKE :p4'
        param = { p1: Article.remove_vowels_n_hamza(params[:q]), p2: "#{Article.remove_vowels_n_hamza(params[:q])} %", p3: "% #{Article.remove_vowels_n_hamza(params[:q])}", p4: "% #{Article.remove_vowels_n_hamza(params[:q])} %" }
      end
    else
      req += if params[:input_lang] == 'ru'
               'LIKE :p1'
             else
               'LIKE :p1 OR ar123_wo_vowels_n_hamza LIKE :p1'
             end
      param = { p1: "%#{Article.remove_vowels_n_hamza(params[:q])}%" }
    end
    @results_count = Article.where([req, param]).where(['ar_inf NOT LIKE ?', '(%)']).count.to_s
    @articles = Article.where([req, param]).where(['ar_inf NOT LIKE ?', '(%)']).page(params[:page])
  end

  def autocomplete
    list = []
    if params[:term] && !params[:term].empty?
      list = Article.where(['ar_inf_wo_vowels_n_hamza LIKE ?', "%#{Article.remove_vowels_n_hamza(params[:term])}%"])
               .where(['ar_inf NOT LIKE ?', '(%)'])
               .limit(100)
               .select('id', 'ar_inf', 'ar_inf_wo_vowels', 'translation')
               .map { |a| Hash[label: "#{a.ar_inf} - #{a.translation.truncate(30)}", value: a.ar_inf_wo_vowels] }
    end
    render json: list
  end

  def blagodarnost; end
end
