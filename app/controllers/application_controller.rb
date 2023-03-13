class ApplicationController < ActionController::Base
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
end
