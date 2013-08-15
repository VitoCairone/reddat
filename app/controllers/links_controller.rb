class LinksController < ApplicationController

  before_filter :ensure_logged_in, except: [:index, :show]

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
    @link = Link.find(params[:id])
    render :show
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
    @link = Link.find(params[:id])
    render :edit
  end

  def update
    @link = Link.find(params[:id])
    @link.update_attributes(params[:link])
    if @link.save
      redirect_to link_url(@link)
    else
      render :edit
    end
  end

  def destroy
    @link = Link.find(params[:id])
    @link.delete
    redirect_to links_url
  end
end
