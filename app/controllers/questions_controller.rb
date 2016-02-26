class QuestionsController < ApplicationController
  before_filter :authenticate_user!, except: [:show]
  before_action :set_post
  before_action :set_question, only: [:show, :edit, :update, :destroy, :open, :close]

  # GET /posts/:post_id/questions/new
  def new
    @question = Question.new
  end

  # POST /posts/:post_id/questions
  def create
    @question = Question.new(question_params.merge(user: current_user, post: @post))

    if @question.save
      redirect_to post_question_path(@post, @question)
    else
      render "new"
    end
  end

  # GET /posts/:post_id/questions/:id
  def show
    @answers = @question.answers.includes(:user)
    @answer = Answer.new
  end

  # GET /posts/:post_id/questions/:id/edit
  def edit
  end

  # PUT/PATCH /posts/:post_id/questions/:id
  def update
    authorize! :update, @question
    if @question.update(question_params)
      redirect_to post_question_path(@post, @question)
    else
      render "edit"
    end
  end

  # DELETE /posts/:post_id/questions/:id
  def destroy
    authorize! :destroy, @question
    @question.destroy
    redirect_to @post
  end

  # PUT /posts/:post_id/questions/:id/close
  def close
    authorize! :close, @question
    @question.update(closed: true)
    redirect_to post_question_path(@post, @question)
  end

  # PUT /posts/:post_id/questions/:id/open
  def open
    authorize! :open, @question
    @question.update(closed: false)
    redirect_to post_question_path(@post, @question)
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
