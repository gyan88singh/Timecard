class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

private

def current_user
  @current_user = User.find(session[:user_id]) if session[:user_id]
end

  helper_method :current_user
  
    def authorize
      redirect_to '/login' unless current_user
    end
    
  def showdate(my_date)
      if my_date
        str_date=my_date.to_date.strftime("%d-%m-%Y")
      else
        str_date=""
      end
      return str_date
    end

end
