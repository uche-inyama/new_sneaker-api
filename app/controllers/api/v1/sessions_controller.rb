class Api::V1::SessionsController < Devise::SessionsController
  skip_before_action :verify_signed_out_user, only: [:destroy]

	def new
		super
	end

	def create
		@user = User.find_by(email: params[:email])
		if @user && @user.valid_password?(params[:password])
			token = JsonWebToken.encode(user_id: @user.id)
			time = Time.now + 24.hours.to_i
			render json: { current_user: @user, token: token, exp: time.strftime("%m-%d-%Y %H:%M")}, status: :ok
			log_in(@user)
			respond_to do |format|
				format.html { redirect_to products_path }
				format.json { render json: @user, status: :ok }
			end
		else
			render json: { error: 'unauthorized' }, status: :unauthorized
		end
	end

	def update
		super
	end

	def destroy
	end
end