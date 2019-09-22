class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @articles = Article.all.order(date: :desc)
  end

  def show
    @article = Article.all.find {|a| a.slug == params[:slug]}
    redirect_to blog_path if @article.nil? || (!@article.published && current_user.nil?)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to article_page_path(@article.slug)
    else
      render :new
    end
  end

  def edit
   @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to article_page_path(@article.slug)
    else
      render :new
    end
  end

  def article_params
    params.require(:article).permit(:title, :content, :published, :cover_image, :description, :date)
  end
end
