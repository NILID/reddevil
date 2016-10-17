class Notification < ActionMailer::Base
  default from: "REDDEVIL <reddevil@luch.podolsk.ru>"

  def birthday(email)
    mail(to: email, subject: t('mailer.birthday'), template_name: 'birthday')
  end

end
