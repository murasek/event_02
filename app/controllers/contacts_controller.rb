class ContactsController < ApplicationController
 before_action :authenticate_user!
  def new
   
      @contact = Contact.new
  
  end
  
  def create
    @contact = Contact.new(contacts_params)
     if params[:back]
       render action: 'new'
    
    else if 
      @contact.save
      redirect_to new_contact_path,notice:"お問い合わせありがとうございます！"
      NoticeMailer.sendmail_contact(@contact).deliver
      else
       render action: 'new' 
      end
     end
  end 
    
    

  def confirm
   @contact = Contact.new(contacts_params)
    render :new if @contact.invalid?
  end
  

  private
    def contacts_params
      params.require(:contact).permit(:name,:email,:content)
    end
end
