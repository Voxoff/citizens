class Api::V1::GroupsController < ApplicationController
  before_action :admin_user, only: %I[create add_users]

  def create
    @group = Group.new(name: group_params[:name])
    if @group.save
      render json: { group: @group }, status: :created
    else
      render json: { message: 'The group was not created' }, status: :unacceptable
    end
  end

  def add_users
    @group = Group.find_by(id: params['id'])
    if @group
      # Admin can only add users per spec
      all_ids = @group.user_ids | group_params[:user_ids]&.map(&:to_i)
      @group.update(user_ids: all_ids)
      render json: { group: @group, user_ids: @group.user_ids }, status: :ok
    else
      render json: { message: 'The group could not be found' }, status: :unacceptable
    end
  end

  def admin_user
    return render json: { message: 'Not authorized' }, status: :unauthorized unless current_admin_user
  end

  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end
end
