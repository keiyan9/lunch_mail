class GroupsController < ApplicationController
  skip_before_filter :load_group, :only => ["new", "create"]

  def new
    @group = Group.new
    @setting = @group.build_setting
  end

  def show
    redirect_to new_group_path unless @group
  end

  def edit
    @setting = @group.setting
  end

  def create
    @group = Group.new(params[:group])
    if @group.save
      current_user.group = @group
      current_user.save
      redirect_to group_path(@group)
    else
      render :action => "new"
    end
  end

  def update
    if @group.update_attributes(params[:group])
      redirect_to group_path(@group)
    else
      render :action => "edit"
    end
  end
end
