class Notification < ActionMailer::Base
  default from: "REDDEVIL <reddevil@luch.podolsk.ru>"

  def birthday(email)
    mail(to: email, subject: t('mailer.birthday'), template_name: 'birthday')
  end

  def new_round(user, round)
    @user = user
    @profile = @user.profile
    @round = round
    mail(to: @user.email, subject: I18n.t('mailer.new_round', round_name: @round.title), template_name: 'new_round')
  end


end
