class LinksController < ApplicationController

  before_filter :ensure_logged_in, except: [:index, :show]
  before_filter :ensure_owner, only: [:edit, :update, :destroy]

  def ensure_owner
    @link = Link.find(params[:id])
    unless @link.user_id == current_user.id
      flash[:errors] ||= []
      flash[:errors] << "You are not the owner of that link."
      redirect_to link_url(@link)
    end
  end

  def create
    params[:link][:user_id] = current_user.id
    params[:link][:upvotes] = 0
    params[:link][:downvotes] = 0
    @link = Link.new(params[:link])
    if @link.save
      redirect_to link_url(@link)
    else
      render :new
    end
  end

  def show
    current_user #ensures @current_user set
    @link = Link.includes(:comments => :user).find(params[:id])
    render :show
    #flash[:link_id] = @link.id #TODO: try moving this before #show
  end

  def new
    @link = Link.new
    render :new
  end

  # Note: Default actions, like this one, actually work without being defined
  def index
    render :index
  end

  def edit
    #@link = Link.find(params[:id]) # set by filter
    render :edit
  end

  def update
    #@link = Link.find(params[:id]) # set by filter
    @link.update_attributes(params[:link])
    if @link.save
      redirect_to link_url(@link)
    else
      render :edit
    end
  end

  def destroy
    #@link = Link.find(params[:id]) # set by filter
    @link.delete
    redirect_to links_url
  end

  #TODO: DRY these two up

  def upvote
    @link = Link.find(params[:id])
    if UserVote.find_by_user_id_and_link_id(@current_user.id, @link.id)
      flash[:errors] ||= []
      flash[:errors] << "You have already voted for that link."
      redirect_to link_url(@link)
    else
    @link.vote_up
    UserVote.create!(user_id: @current_user.id, link_id: @link.id)
    render :show
  end

  def downvote
    @link = Link.find(params[:id])
    if UserVote.find_by_user_id_and_link_id(@current_user.id, @link.id)
      flash[:errors] ||= []
      flash[:errors] << "You have already voted for that link."
      redirect_to link_url(@link)
    else
    @link.vote_down
    UserVote.create!(user_id: @current_user.id, link_id: @link.id)
    render :show
  end
end
