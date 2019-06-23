class UsersController < ApplicationController
  before_action :set_user

  def update
    @user.update(user_params)
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

   def update_newsletter
    @user.update(user_params)
    redirect_to root_path
  end

  def postcode_checker
  end

  def postcode_result
    @user.check_postcode(user_params[:postcode])
    if @user.valid_postcode?
      redirect_to new_customer_path, notice: 'Yes! We deliver to your area!'
    else
      @customer = Customer.create(user_id: current_user.id)
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:postcode, :newsletter, :standard)
  end
end
