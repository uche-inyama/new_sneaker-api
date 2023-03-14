class Api::V1::RegistrationsController < Devise::RegistrationsController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.json { render json: @user, status: :ok }
      else
        format.json { render json: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.permit(:email, :username, :password, :password_confirmation)
  end

end