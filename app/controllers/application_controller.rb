class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	skip_before_action :verify_authenticity_token
	include SessionsHelper
	include JsonWebToken

	def not_found
		render json: { error: 'not found' }
	end

	def authorize_request
		header = request.headers['Authorization']
		header = header.split(' ').last if header
		begin
			@decode = JsonWebToken.decode(header)
			@current_user = User.find(@decoded[:user_id])
		rescue ActiveRecord::RecordNotFound => e
			render json: { errors: e.message }, status: :unauthorized
		rescue JWT::DecodeError => e
			render json: { errors: e.message }, status: :unauthorized
		end
	end

	private

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
	end
end
