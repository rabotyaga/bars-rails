# frozen_string_literal: true

class LogsController < ApplicationController
  before_action :authenticate_user!

  def index
    @logs = if current_user.try(:is_admin?)
              Log.all.page(params[:page])
            else
              current_user.logs.page(params[:page])
            end
  end
end
