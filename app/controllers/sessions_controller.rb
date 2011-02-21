class SessionsController < ApplicationController
  skip_before_filter :authorize, :except => :destroy
  
  # GET /login
  def new
    redirect_to invoices_path if signed_in?
  end
  
  # POST /login
  def create
    if @current_user = User.authenticate(params[:email], params[:password])
      session[:user_id] = @current_user.id
      redirect_to invoices_path, :notice => t('.login_message')
    else
      @login_error = true
      respond_to do |format|
        format.html { render :action => :new }
      end
    end
  end
  
  # DELETE /logout
  def destroy
    session[:user_id] = nil
    redirect_to show_login_path, :notice => t('.logout_message')
  end

end
