class LogsController < ApplicationController
  before_filter :authenticate_user!

  def index
    if current_user.try(:is_admin?)
      @logs = Log.all.page(params[:page])
    else
      @logs = current_user.logs.page(params[:page])
    end
  end

end
