class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    postcode_checker_user_path(resource)
  end
end
