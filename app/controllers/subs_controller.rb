class SubsController < ApplicationController

  before_filter :ensure_logged_in, except: [:index, :show]

  def create
    #params[:sub][:moderator] = current_user.id #if creator is mod by default
    @sub = Sub.new(params[:sub])
    if @sub.save
      redirect_to sub_url(@sub)
    else
      render :new
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def new
    @sub = Sub.new
    render :new
  end

  def index
    render :index
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    @sub.update_attributes(params[:sub])
    if @sub.save
      redirect_to sub_url(@sub)
    else
      render :edit
    end
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.delete
    redirect_to subs_url
  end

end
