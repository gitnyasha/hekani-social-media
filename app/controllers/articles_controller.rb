class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all.order(created_at: :desc)
  end

  def show
    @replys = []
    @article.replies.each do |reply|
      @user = User.find(reply.user_id)
      @replys.push({ id: reply.id, user: @user.email, reply: reply.title, created: reply.created_at })
    end
    render json: { article: @article, replies: @replys, likes: @article.likes.count }
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
    current_user = User.find(1)
    @article = current_user.articles.build(articles_params)
    if @article.save
      render json: { status: "success", article: @article }
    else
      render json: { status: "Error creating post" }
    end
  end

  def edit
  end

  # edit the article
  def update
    if @article.update(articles_params)
      render json: { status: "success", article: @article }
    else
      render json: { status: "Error updating the post" }
    end
  end

  def destroy
    if @article.destroy
      render json: { status: "success" }
    else
      render json: { status: "Error destroying the post" }
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def articles_params
    params.require(:article).permit(:title, :link, :image)
  end
end
