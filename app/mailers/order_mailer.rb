class OrderMailer < ApplicationMailer
  default from: 'no-reply@gmail.com',
          bcc: 'receiving-address@gmail.com'

  def confirm_order(recipient)
    @account = recipient
    mail(to: recipient.email, subject: 'Your Order with bookstore.com')
  end
end
