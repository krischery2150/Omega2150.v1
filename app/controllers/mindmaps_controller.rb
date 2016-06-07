class MindmapsController < ApplicationController
  before_action :find_mindmap, only: [:show, :edit, :update, :destroy]
  before_action :find_capsule, only: [:new, :create, :update, :destroy]
  before_action :authenticate_author!

  def index
    @mindmaps = Mindmap.all.order('created_at DESC')
  end

  def new
    @mindmap = current_author.mindmaps.build
  end

  def create
     @mindmap = current_author.mindmaps.build(mindmap_params)
    if @mindmap.save
      redirect_to @mindmap, notice:"You have successfully created a Mindmap"
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @mindmap.update(mindmap_params)
      redirect_to @mindmap , notice:" You have successfully updated Your Mindmap"
    else
      render 'edit'
    end
  end

  private

  def find_mindmap
    @mindmap = Mindmap.find(params[:id])
  end

  def find_capsule
    @capsule = current_author.capsules.find_by(params[:id])
  end

  def mindmap_params
    params.require(:mindmap).permit(:src, :src_purpose, :capsule_id )
  end
end
