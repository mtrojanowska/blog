class ArticlesController < ApplicationController
  before_action :find_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update,:destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def create
   @article = Article.new(article_params)
     @article.user_id = session[:user_id]
     if @article.save
        flash[:success] = "Article has been saved successfully"
        redirect_to article_path(@article)
      else
        render 'new'
      end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @article.destroy
    redirect_to articles_path
    flash[:danger]="Article was successfully destroyed"
  end


  private

  def find_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content, :description)
  end

  def require_same_user
    if current_user != @article.user
      flash[:danger] = "You can't do that"
      redirect_to root_path
    end
  end
end
