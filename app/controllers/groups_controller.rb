class GroupsController < ApplicationController
  skip_before_filter :load_group, :authenticate_user!
  def new
    @group = Group.new
    @group.users.build
  end

  def create
    params[:group][:users_attributes].values.first.store("roll","admin")
    @group = Group.create(params[:group])
    if @group.errors.full_messages.empty?
      sign_in @group.users.first
      redirect_to new_group_setting_path(@group)
    else
      render action: "new"
    end
  end

end
