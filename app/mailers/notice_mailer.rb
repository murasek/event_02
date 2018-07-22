class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_topic.subject
  #
  def sendmail_topic(topic)


    @topic = topic
  /ブログ書いた人にメールする/
    mail to: @topic.user.email,
         subject: '【Fakebook】トピックが投稿されました'

  end

   def sendmail_contact(contact)
    @contact = contact

    mail to: contact.email,
       subject: '【FakebookFakebook】問い合わせが投稿されました'
   end
end
