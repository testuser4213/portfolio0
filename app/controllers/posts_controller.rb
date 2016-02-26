class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  def index
    @posts = Post.includes(:tags).order(created_at: :desc).page params[:page]
  end

  # GET /posts/search
  def search
    @posts = Post.ransack(params[:q]).result.includes(:tags).page params[:page]
    @query = params[:q]["title_or_body_cont"]
  end

  def tag
    @posts = Post.tagged_with(params[:tag]).includes(:tags).order(created_at: :desc).page params[:page]
    @tag = params[:tag]
  end

  # GET /posts/1
  def show
    @questions = @post.questions.includes(:user)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    authorize! :create, Post
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  def update
    authorize! :update, @post
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /posts/1
  def destroy
    authorize! :destroy, @post
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :str_tags)
    end
end
