class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_event.subject
  #
  def sendmail_event(event)


    @event = event
  /イベントを書いた人にメールする/
    # mail to: @event.user.email,
    # mail to: k01_mura@yahoo.co.jp,
         # subject:'とーこー'

  end

   def sendmail_contact(contact)
    @contact = contact

    mail to: contact.email,
       subject: '【event_02event】問い合わせが投稿されました'
   end
end
