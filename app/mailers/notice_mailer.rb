class NoticeMailer < ApplicationMailer

  def sendmail_event(event)
   @event = event
   mail to:'k01_mura@yahoo.co.jp'
   mail to: event.user.email,
    subject:'【event】イベントが投稿されました'
  end

   def sendmail_contact(contact)
    @contact = contact

    mail to: contact.email,
       subject:'【event_02event】問い合わせが投稿されました'
   end


end
