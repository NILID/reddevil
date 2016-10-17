class CommentsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @comments = Comment.where('id > ?', params[:after_id].to_i).order('created_at DESC')
  end

  def new
    @comment = Comment.new
    @comments = Comment.order('created_at DESC')
  end

  def create
    respond_to do |format|
      if current_user
        @comment = current_user.comments.build(params[:comment])
        if @comment.save
          flash.now[:success] = 'Your comment was successfully posted!'
        else
          flash.now[:error] = 'Your comment cannot be saved.'
        end
        format.html {redirect_to root_url}
        format.js
      else
        format.html {redirect_to root_url}
        format.js {render nothing: true}
      end
    end
  end
end