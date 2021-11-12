class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    # select by articles by category user is following
    if @current_user
      @articles = Article.where(article_category_id: @current_user.articles_subscribed).order(created_at: :desc)
    else
      @articles = Article.all.order(created_at: :desc)
    end
    @categories = ArticleCategory.all
  end

  def show
    @replys = []
    @article.replies.each do |reply|
      @user = User.find(reply.user_id)
      @replys.push({ id: reply.id, user: @user.email, reply: reply.title, created: reply.created_at })
    end
  end

  def new
    @article = Article.new
    @url = params[:search]
    if @url
      @myarticles = []
      doc = Nokogiri::HTML(URI.open(@url).read)
      @title = doc.css(".entry-title").text
      @image = doc.css("img").attr("src") ? doc.css("img.wp-post-image").attr("src").value : doc.css("img.wp-post-image").attr("src")
      @link = @url
    end
  end

  def create
    current_user = User.find(session[:user_id])
    @article = current_user.articles.build(articles_params)
    if @article.save
      redirect_to articles_path
      flash[:success] = "Article created"
    else
      flash[:error] = "Error creating article"
      render :new
    end
  end

  def edit
  end

  # edit the article
  def update
    if @article.update(articles_params)
      redirect_to @article
    else
      render edit
    end
  end

  def destroy
    if @article.destroy
      redirect_to articles_path
    else
      render json: { status: "Error destroying the post" }
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def articles_params
    params.require(:article).permit(:title, :link, :image, :article_category_id)
  end
end
