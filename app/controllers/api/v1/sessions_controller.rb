class Api::V1::SessionsController < Devise::SessionsController
  skip_before_action :verify_signed_out_user, only: [:destroy]

	def new
		super
	end

	def create
		@user = User.find_by(email: params[:user][:email])
		if @user && @user.valid_password?(params[:user][:password])
			token = JsonWebToken.encode(user_id: @user.id)
			time = Time.now + 24.hours.to_i
			log_in(@user)
			respond_to do |format|
				format.html { redirect_to products_path }
				format.json {	render json: { current_user: @user, token: token, exp: time.strftime("%m-%d-%Y %H:%M")}, status: :ok }
			end
			# render json: { current_user: @user, token: token }, status: :ok
		else
			render json: { error: 'unauthorized' }, status: :unauthorized
		end
	end

	def update
		super
	end

	def destroy
		super
	end
end