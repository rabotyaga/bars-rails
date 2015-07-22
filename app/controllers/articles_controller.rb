class ArticlesController < ApplicationController
  before_filter :set_article, only: [:edit, :update, :destroy]

  before_filter :authenticate_user!, except: [:index]
  before_filter(:only => [:new, :create]) do
    redirect_to root_path unless current_user.try(:can_add)
  end
  before_filter(:only => [:edit, :update]) do
    redirect_to root_path unless current_user.try(:can_edit)
  end
  before_filter(:only => [:destroy]) do
    redirect_to root_path unless current_user.try(:can_delete)
  end

  #def import
  #  Article.import(params[:file])
  #  redirect_to articles_path, notice: "Imported successfully"
  #end

  # GET /articles
  # GET /articles.json
  def index
    if params[:id] && (@article = Article.find(params[:id]))
      root_article = (@article.is_root ? @article : @article.root_article)
      params[:first_letter_id] = @article.first_letter.id
      #first_article = Article.find(@article.first_letter.first_article_id)
      #page = (@article.nr - first_article.nr) / Kaminari.config.default_per_page + 1
      page = Article.where(["first_letter_id = ? AND is_root = TRUE AND nr < ?", params[:first_letter_id], root_article.nr]).count + 1
      params[:id] = nil
    else
      page = params[:page]
    end
    @first_letters = FirstLetter.all
    params[:first_letter_id] || params[:first_letter_id] = 1
    @articles = Article.where({ :first_letter_id => params[:first_letter_id], :is_root => true }).page(page).per(1)
    @all_articles = @articles.to_a + @articles.first.sub_articles.to_a
    if !current_user.try(:can_any) && @articles.first.ar_inf =~ /^\(.+\)$/
      @all_articles = @articles.first.sub_articles.to_a
    end
  end

  #def offline
  #  @first_letters = FirstLetter.all
  #  @articles = Article.all
  #  render :layout => 'offline'
  #end

  # GET /articles/new
  def new
    @article = Article.new
    preceding_article = Article.find(params[:after_id])
    @article.nr = preceding_article.nr + 1
    session[:back_from_create] = request.referer
  end

  # GET /articles/1/edit
  def edit
    session[:back_from_update] = request.referer
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    preceding_article = Article.find(params[:after_id])
    @article.first_letter_id = preceding_article.first_letter_id
    if !@article.is_root?
      @article.root_id = preceding_article.root_id
    end
    respond_to do |format|
      if @article.save
        Log.create(:user => current_user,
                   :article => @article,
                   :action => Action.find(1),
                   :data => @article.attributes)
        format.html { redirect_to session[:back_from_create], notice: I18n.t(:article_created) }
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      dup = @article.dup
      if @article.update(article_params)
        diff = {}
        for attr in [:nr, :ar_inf, :ar_inf_wo_vowels, :translation, :is_original, :source, :page, :is_root, :form, :opt, :mn1, :ar1, :mn2, :ar2, :mn3, :ar3]
          if @article[attr] != dup[attr]
            diff.merge!({ attr => { :old => dup[attr], :new => @article[attr] } })
          end
        end
        Log.create(:user => current_user,
                   :article => @article,
                   :action => Action.find(2),
                   :data => diff)
        format.html { redirect_to session[:back_from_update], notice: I18n.t(:article_updated) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    Log.create(:user => current_user,
               :article => @article,
               :action => Action.find(3),
               :data => @article.attributes)
    @article.nr = nil
    @article.save
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:nr, :is_root, :ar_inf, :is_original, :source, :page, :form, :opt, :mn1, :ar1, :mn2, :ar2, :mn3, :ar3, :translation)
    end
end
