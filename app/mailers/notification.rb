class Notification < ActionMailer::Base
  default from: "REDDEVIL <reddevil@luch.podolsk.ru>"

  def birthday(email)
    mail(to: email, subject: t('mailer.birthday'), template_name: 'birthday')
  end

  def welcome(email)
    mail(to: email, subject: 'welcome', template_name: 'welcome')
  end


end
