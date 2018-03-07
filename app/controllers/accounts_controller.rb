# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action do
    redirect_to root_path unless current_user.try(:is_admin?)
  end

  def index
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to action: 'index', notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'index' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:active, :can_edit, :can_add, :can_delete)
  end
end
