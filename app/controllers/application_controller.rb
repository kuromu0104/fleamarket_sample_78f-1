class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :basic_auth, if: :production?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
       keys: [:nickname, :email, :password, :password_confirmation, profile_attributes: [:first_name, :family_name, :first_name_kana, :family_name_kana, :birth_date], sending_destinaton_attributes: [:destination_first_name, :destination_family_name, :destination_first_name_kana, :destination_first_name_kana, :post_code, :city, :house_number, :building_name, :phone_number]] )
  end

  def after_sign_in_path_for(resource)
    items_path
  end
  
  def after_sign_out_path_for(resource)
    items_path
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials[:basic_auth][:user] &&
      password == Rails.application.credentials[:basic_auth][:pass]
    end
  end

  def production?
    Rails.env.production?
  end

end
