class BoxesController < ApplicationController
  before_action :require_login
  before_action :box_available?, :only => [:update]
  before_filter :check_for_new_cancel, :only => [:create]

  def update
    @box = Box.find_by(:id => box_params[:id])
    @box.update(update_box_user)

    if @box.save
      flash[:success] = "Box saved!"
      redirect_to :back
    else
      flash[:error] = "Box not saved"
      redirect_to :back
    end
  end

private

  def box_params
    params.permit(:id, :box_type)
  end

  def picked
    "Pick" == box_params[:box_type]
  end

  def update_box_user
    picked ? { :user_id => @current_user.id } : { :user_id => nil }
  end
end