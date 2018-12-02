module ApplicationHelper

def profile_img(user)

     return image_tag(user.avatar, alt: user.name,) if user.avatar?

    unless user.provider.blank?
      img_url = user.image_url
    else
      img_url = 'no_image.png'
    end
    image_tag(img_url,alt: user.name )
end





def url_for_twitter(user)
   "https://twitter.com/#{user.name}"
 end


 def devise_error_messages
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
