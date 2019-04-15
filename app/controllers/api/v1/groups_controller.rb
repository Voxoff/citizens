class Api::V1::GroupsController < ApplicationController
  def create
    return render json: { message: 'Not authorized' }, status: :unauthorized unless current_admin_user

    @group = Group.new(name: params[:name])
    if @group.save
      render json: { group: @group }, status: :created
    else
      render json: { message: 'The group was not created' }, status: :unacceptable
    end
  end

  # def add_users
  #   return render json: { message: 'Not authorized' }, status: :unauthorized unless current_admin_user

  #   # Suppose we get a hash with {group_id => [user_ids]}
  #   # {1 => [1,2,3], 3 => 3}


  # end
end
