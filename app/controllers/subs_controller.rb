class SubsController < ApplicationController

  before_filter :ensure_logged_in, except: [:index, :show]
  before_filter :ensure_moderator, only: [:edit, :update, :destroy]

  def ensure_moderator
    @sub = Sub.find(params[:id])
    unless @sub.moderator == current_user.id
      flash[:errors] ||= []
      flash[:errors] << "You are not the owner of that sub."
      redirect_to sub_url(@sub)
    end
  end

  def create
    #params[:sub][:moderator] = current_user.id #if creator is mod by default

    # this block clears out the sub_ids from any otherwise blank new links
    # so that they can be rejected properly
    links_attrs = params[:sub][:links_attributes]
    5.times do |i|
      link_attr = links_attrs[i.to_s]
      if (link_attr[:title].blank? &&
        link_attr[:url].blank? &&
        link_attr[:text].blank?)
        link_attr[:sub_ids] = nil
      end
    end

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
    @allow_simulpost = true
    @sub = Sub.new
    render :new
  end

  def index
    render :index
  end

  def edit
    #@sub = Sub.find(params[:id]) # set by filter
    render :edit
  end

  def update
    #@sub = Sub.find(params[:id]) # set by filter
    @sub.update_attributes(params[:sub])
    if @sub.save
      redirect_to sub_url(@sub)
    else
      render :edit
    end
  end

  def destroy
    #@sub = Sub.find(params[:id]) # set by filter
    @sub.delete
    redirect_to subs_url
  end

end
