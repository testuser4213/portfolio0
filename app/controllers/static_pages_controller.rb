class StaticPagesController < ApplicationController
  layout 'empty', only: [:home]

  # GET /
  def home
    @latest_tuts = Post.order(created_at: :desc).limit(5)
  end

  # GET /about
  def about
  end
end
