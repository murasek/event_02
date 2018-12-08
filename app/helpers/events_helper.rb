module EventsHelper
    def choose_new_or_edit
      if action_name == 'new' || action_name == 'confirm'
      confirm_events_path
      elsif action_name == 'edit'
      event_path
      end
    end

    def current_user
     @current_user ||= User.find_by(id: session[:user])
   end

   def logged_in?
     current_user != nil
   end


   def devise_error_messages2
     return "" if resource.errors.empty?
     html = ""
     # エラーメッセージ用のHTMLを生成
     messages = resource.errors.full_messages.each do |msg|
       html += <<-EOF
         <div class="error_field alert alert-danger" role="alert">
           <p class="error_msg">#{msg}</p>
         </div>
       EOF
     end
     html.html_safe
   end

end
