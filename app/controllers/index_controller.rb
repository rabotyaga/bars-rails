class IndexController < ApplicationController
  def index

  end

  def search
    if params[:input_lang] == "ru"
      req = "translation "
    else
      req = "ar_inf_wo_vowels_n_hamza "
    end

    if params[:search_type] == 'exact'
      if params[:input_lang] == "ru"
        req += "LIKE ?"
        param = "% #{params[:q]} %"
      else
        req += "= ?"
        param = Article.remove_vowels_n_hamza(params[:q])
      end
    else
      req += "LIKE ?"
      param = "%#{Article.remove_vowels_n_hamza(params[:q])}%"
    end
    @articles = Article.where([req, param]).where(["ar_inf NOT LIKE ?", "(%)"]).page(params[:page])
  end

  def autocomplete
    list = Article.where(["ar_inf_wo_vowels_n_hamza LIKE ?", "%#{Article.remove_vowels_n_hamza(params[:term])}%"]).where(["ar_inf NOT LIKE ?", "(%)"]).select("id", "ar_inf", "ar_inf_wo_vowels", "translation").map{ |a| Hash[label: "#{a.ar_inf} - #{a.translation.truncate(30)}", value: a.ar_inf_wo_vowels]}
    render :json => list
  end

end
