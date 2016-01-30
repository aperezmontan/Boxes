class BoxesController < ApplicationController
  before_action :require_login
  before_filter :check_for_new_cancel, :only => [:create] #TODO GET RID OF THIS CALLBACK

  def update
    @box = Box.find_by(:id => box_params[:id])

    if @box.update_box(@current_user)
      flash[:success] = "Box saved!"
      redirect_to :back
    else
      flash[:error] = @box.errors
      redirect_to :back
    end
  end

private

  def box_params
    params.permit(:id)
  end
end