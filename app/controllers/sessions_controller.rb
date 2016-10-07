class SessionsController < ApplicationController
 
  # include active_directory_user
  
  def index
    
  end
   
   def new
     username1 = ENV['USERNAME']
    # raise user.inspect    "gyanprakash.singh"
       username = username1
       
      domain = '@tandon.local' 
      
     user = username + domain 
    # user =  'suhas.dabhade@tandon.local'
    # raise user.inspect
       
    # usersearch  = User.domain_search(user)
     
     
     if (User.domain_authenticates(user)) 
         
             if( User.db_authenticates(username))
       
          #if user && userdb
           
                 redirect_to :action => 'time_home', :controller=>"time_reports",:notice => "Logged in!"
             else
               render :action => "index", :layout => false
             end
          #elsif user && !userdb
       
             #   flash[:error] = "You are not authorized user For ARS"
                
                  #render :action => "index", :layout => false
          #elsif !user 
          #     render :action => "index_AD", :layout => false  
               
            # redirect_to :action => 'login',:controller => 'logins' 
            
          else
            render :action => "index_AD", :layout => false 
          end   
        
     
       
   end
 
 def create
  # user = ActiveDirectoryUser.authenticate(params[:User][:user_name],params[:User][:password])
   
   user = User.domain_authenticates(params[:User][:user_name], params[:User][:password])
   if user
     session[:user_id] = user.id
     logged_in_user = User.find_by_id(user.id)
     
     new_login_details = LoginDetail.new(:user_id => logged_in_user.id  , :login_time => Time.now , :remarks => "Active")
    # raise new_login_details.login_time.inspect
     new_login_details.save!
     session[:login] = new_login_details.id
      
    # raise logged_in_user.inspect 
     #redirect_to root_url, :notice => "Logged in!"
     redirect_to :action => 'index', :controller=>"projects",:notice => "Logged in!"
    # render :layout => "standard"
       
   else
     flash[:notice] = "You are not authorized user"
     #flash.now.alert = "Invalid email or password"
    # flash[:notice] = "Invalid User/Password Combination."
    # render "new"
     redirect_to root_url
 
   end
 end
 
 def destroy
  # raise session[:user_id].inspect
   session[:user_id] = nil
     
   redirect_to root_url  #, :notice => "Logged out!"
 end

end
