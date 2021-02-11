class Admin::UsersController < ApplicationController
    before_action :set_user, only: %i[ show edit update destroy ]
    before_action :if_not_admin

  # GET /users or /users.json
  def index
    #@users = User.all
    @users = User.all.includes(:tasks)
  end

  # GET /users/1 or /users/1.json
  def show
    #@user = current_user
    @tasks = @user.tasks
    # unless current_user.id == @user.id
    #   redirect_to tasks_path
    # end
  end
  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    
    @user = User.new(user_params)

    #respond_to do |format|
      if @user.save
        # session[:user_id] = @user.id
        redirect_to admin_users_path, notice: "User was successfully created." 
        
        #format.html { redirect_to @user, notice: "User was successfully created." }
        #format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    #end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "User was successfully destroyed."
    #respond_to do |format|
      #format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      #format.json { head :no_content }
    #end
    else 
      redirect_to admin_users_path, notice: "You can't destroy cuz you're only admin user "
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end  
    def if_not_admin
        redirect_to root_path, notice: "管理者以外はアクセスできません" unless current_user.admin?
    end
end

