class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path, notice: 'You have created group successfully.'
    else
      render :new
    end
  end

  def index
    @book = Book.new
    @groups = Group.all
  end
  
  def show
    @book = Book.new
    @group = Group.find(params[:id])
  end
  
  def edit
    @group = Group.find(params[:id])
  end
  
  def update
    
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end

end
