class OrderMailer < ApplicationMailer
  default from: 'no-reply@gmail.com',
          bcc: Rails.application.credentials.GMAIL_USERNAME

  def confirm_order(recipient)
    @account = recipient
    mail(to: recipient.email, subject: I18n.t('mailers.recipient'))
  end
end
