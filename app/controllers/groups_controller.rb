class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.users << current_user #@group.usersにグループ作成者を追加
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
  end
  
  def update
    if @group.update(group_params)
      redirect_to groups_path, notice: 'You have updated group successfully.'
    else
      render :edit
    end
  end
  
  def join
    @group = Group.find(params[:group_id])
    @group.users << current_user #@group.usersにcurrent_userを追加
    redirect_to groups_path
  end
  
  def destroy
    @group = Group.find(params[:id])
    @group.users.delete(current_user)
    redirect_to groups_path
  end
  
  def new_mail
    @group = Group.find(params[:group_id])
  end
  
  def send_mail
    @group = Group.find(params[:group_id])
    group_users = @group.users
    @mail_title = params[:mail_title]
    @mail_content = params[:mail_content]
    ContactMailer.send_mail(@mail_title, @mail_content,group_users).deliver
  end
  
  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end
  
  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end

end
