class ArticlesController < ApplicationController
  def start
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
     if @article.save
        flash[:success] = "Article has been saved successfully"
        redirect_to article_path(@article)
      else
        render 'new'
      end
end

def edit
@article = Article.find(params[:id])
end

def update
  @article = Article.find(params[:id])
  if @article.update(article_params)
    flash[:success] = "Article was successfully updated"
    redirect_to article_path(@article)
  else
    render 'edit'
  end
end

def show
  @article=Article.find(params[:id])
end

def destroy
  @article = Article.find(params[:id])
  @article.destroy
  redirect_to articles_path
  flash[:danger]="Article was successfully destroyed"
end


  private
  def article_params
    params.require(:article).permit(:title, :content, :description)
  end
end
