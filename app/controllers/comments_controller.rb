class CommentsController < ApplicationController
  before_filter :ensure_logged_in, except: [:index, :show]
  before_filter :ensure_owner, only: [:edit, :update, :destroy]

  def ensure_owner
    @comment = Comment.find(params[:id])
    unless @comment.user_id == current_user.id
      flash[:errors] ||= []
      flash[:errors] << "You are not the owner of that comment."
      redirect_to comment_url(@comment)
    end
  end

  def create
    params[:comment][:user_id] = current_user.id
    #params[:comment][:link_id] = flash[:link_id]
    @comment = Comment.new(params[:comment])
    if @comment.save
      redirect_to link_url(@comment.link_id)
    else
      render :new
    end
  end

  # def show
  #   @comment = Comment.find(params[:id])
  #   render :show
  # end

  def new
    @comment = Comment.new
    render :new
  end

  def index
    render :index
  end

  def edit
     #@comment = Comment.find(params[:id]) # set by filter
    render :edit
  end

  def update
    #@comment = Comment.find(params[:id]) # set by filter
    @comment.update_attributes(params[:comment])
    if @comment.save
      redirect_to comment_url(@comment)
    else
      render :edit
    end
  end

  def destroy
     #@comment = Comment.find(params[:id]) # set by filter
    @comment.delete
    redirect_to links_url
  end
end
