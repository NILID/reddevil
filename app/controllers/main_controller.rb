class MainController < ApplicationController
  layout 'main'

  def index
    now       = DateTime.now.beginning_of_day
    tomorrow  = DateTime.tomorrow.beginning_of_day
    yesterday = DateTime.yesterday.beginning_of_day

    @messages = Message.where(close: false)

    @bduser                = Member.shown.find_births_for(now, now + 30.days)
    @bdusers_yesterday     = Member.shown.find_births_for(yesterday).group_by {|u| [u.birth.strftime("%m"), u.birth.strftime("%d")]}
    @bdusers_prevyesterday = Member.shown.find_births_for(yesterday - 1.day).group_by {|u| [u.birth.strftime("%m"), u.birth.strftime("%d")]}

    @bdusers_today    = @bduser.birth_today.group_by {|u| [u.birth.strftime("%m"), u.birth.strftime("%d")]}
    @bdusers_tomorrow = @bduser.find_births_for(tomorrow).group_by {|u| [u.birth.strftime("%m"), u.birth.strftime("%d")]}
    @bdusers_month    = @bduser.find_births_for(tomorrow + 1.day, now + 30.days).group_by {|u| [(u.birth.month < DateTime.now.month ? 1 : 0), u.birth.strftime("%m"), u.birth.strftime("%d")]}

    @vacations      = Vacation.where('startdate <= ?', now).where('enddate >= ?', now)
                              .order(:enddate)
                              .includes(:member)
    @vacations_soon = Vacation.where('startdate > ?', DateTime.now)
                              .where('startdate <= ?', DateTime.now + 7.days)
                              .order(:startdate)
                              .includes(:member)

    if current_user
      @events      = current_user.events.where('start_date <= ?', now)
                                        .where('end_date >= ?', now)
                                        .order(:end_date)
      @events_soon = current_user.events.where('start_date >= ?', DateTime.now + 1.days)
                                        .where('start_date <= ?', DateTime.now + 7.days)
                                        .order(:start_date)
      if current_user.member
        @current_vacations_soon = current_user.member.vacations
                                      .where('startdate >= ?', DateTime.now)
                                      .order(:startdate).first
      end
    end

    @holidays_today    = Holidays.on(now, :full_ru, :reddevil_ru)
    @holidays_tomorrow = Holidays.on(tomorrow, :full_ru, :reddevil_ru)

    @docs = Doc.where(show_last_flag: true).where('updated_at >=?', now - 10.days).order(updated_at: :desc) + Doc.where(show_last_flag: true).group_by_day(:created_at, last: 10).order(updated_at: :desc)
    @docs.uniq!
  end
end
