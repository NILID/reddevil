class Notification < ApplicationMailer
  def birthday(email)
    mail(to: email, subject: t('mailer.birthday'), template_name: 'birthday')
  end

  def new_round(user, round)
    @user = user
    @round = round
    mail(to: @user.email, subject: I18n.t('mailer.new_round', round_name: @round.title), template_name: 'new_round')
  end

  def new_note(note)
    @note = note
    mail(to: 'dailyin@luch.com.ru', subject: I18n.t('mailer.new_note'), template_name: 'new_note')
  end
end
