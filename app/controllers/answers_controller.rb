class AnswersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_post
  before_action :set_question
  before_action :set_answer, only: [:edit, :update, :destroy]

  # POST /posts/:post_id/questions/:question_id/answers
  def create
    @answer = Answer.new(answer_params.merge(user: current_user, question: @question))

    respond_to do |format|
      if @answer.save
        format.html { redirect_to post_question_path(@post, @question) }
        format.js {}
      else
        format.html { render "questions/show" }
        format.js {}
      end
    end
  end

  # DELETE /posts/:post_id/questions/:question_id/answers/:id
  def destroy
    authorize! :destroy, @answer
    @answer.destroy()

    respond_to do |format|
      format.html { redirect_to post_question_path(@post, @question) }
      format.js {}
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end
end
