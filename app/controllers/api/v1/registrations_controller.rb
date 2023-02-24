class Api::V1::RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.json { render json: @user, status: :ok }
        format.html { redirect_to products_path }
      else
        format.json { render json: :unprocessable_entity }
        format.html { render :new }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end
end