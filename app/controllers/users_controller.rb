class UsersController < ApplicationController
  authorize_resource

  # GET /users
  def index
    @users = User.all.page params[:page]
  end

  # GET /users/:id
  def show
    @user = User.find(params[:id])
    @answers = @user.answers.order(created_at: :desc).includes(:question).limit(4)
    @questions = @user.questions.order(created_at: :desc).limit(4)
  end
end
