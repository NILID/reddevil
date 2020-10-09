class MainController < ApplicationController
  before_action :authenticate_user!, only: :calendar
  layout :get_layout, only: :index

  def index
    if current_user
      now       = DateTime.now.beginning_of_day
      tomorrow  = DateTime.tomorrow.beginning_of_day
      yesterday = DateTime.yesterday.beginning_of_day

      @bduser                = Member.shown.find_births_for(now, now + 30.days)
      @bdusers_yesterday     = Member.shown.find_births_for(yesterday).group_by {|u| [u.birth.strftime("%m"), u.birth.strftime("%d")]}
      @bdusers_prevyesterday = Member.shown.find_births_for(yesterday - 1.day).group_by {|u| [u.birth.strftime("%m"), u.birth.strftime("%d")]}

      @bdusers_today    = @bduser.birth_today.group_by {|u| [u.birth.strftime("%m"), u.birth.strftime("%d")]}
      @bdusers_tomorrow = @bduser.find_births_for(tomorrow).group_by {|u| [u.birth.strftime("%m"), u.birth.strftime("%d")]}
      @bdusers_month    = @bduser.find_births_for(tomorrow + 1.day, now + 30.days).group_by {|u| [(u.birth.month < DateTime.now.month ? 1 : 0), u.birth.strftime("%m"), u.birth.strftime("%d")]}

      all_vacations     = Vacation.includes(:member)
                                  .where('startdate <= ?', now)
                                  .where('enddate >= ?',   now)
                                  .where(members: { archive_flag: false })
                                  .order(:enddate)

      @vacations      = all_vacations.where(flag: 'rest')
      @sickdays       = all_vacations.where(flag: 'sick')
      @tripdays       = all_vacations.where(flag: 'trip')

      @remote_members = Member.where(remote_flag: true).order(:surname)

      @vacations_soon = Vacation.includes(:member)
                                .where('startdate > ?',  DateTime.now)
                                .where('startdate <= ?', DateTime.now + 7.days)
                                .where(flag: 'rest')
                                .where(members: { archive_flag: false })
                                .order(:startdate)


      @events      = current_user.events.where('start_date <= ?', now)
                                        .where('end_date >= ?',   now)
                                        .order(:end_date)
      @events_soon = current_user.events.where('start_date >= ?', DateTime.now + 1.days)
                                        .where('start_date <= ?', DateTime.now + 7.days)
                                        .order(:start_date)
      if current_user.member
        @current_vacations_soon = current_user.member.vacations
                                      .where('startdate >= ?', now)
                                      .where(flag: 'rest')
                                      .order(:startdate).first
        @current_vacation       = current_user.member.vacations
                                      .where('startdate <= ?', now)
                                      .where('enddate >= ?',   now)
                                      .where(flag: 'rest')
                                      .first
      end
      @holidays_today    = Holidays.on(now,      :full_ru, :reddevil_ru)
      @holidays_tomorrow = Holidays.on(tomorrow, :full_ru, :reddevil_ru)

      @docs = (Doc.where('updated_at >= ?', now - 10.days).
            or(Doc.where('created_at >= ?', now - 10.days)))
               .where(show_last_flag: true)
               .order(updated_at: :desc)
    else
      render template: 'main/index_unreg'
    end
  end

  def infocenter
  end

  def operative
  end

  def project
    @cards = Card.where(category: 'project')
  end

  def problem
  end

  def security
  end

  def quality
  end

  def orders
  end

  def personal
  end

  def products
  end

  def strength
  end

  def salary
  end

  def vac
    @q = Member.shown.ransack(params[:q])
    @q.sorts = 'surname' if @q.sorts.empty?
    @q.department_id_eq = current_user.member.department_id if current_user.member && !params[:q] # TODO: check current_user and member
    @departments = Department.order(:title).includes(:members)
    @members = @q.result(distinct: true)

    @current_date = params[:date] ? DateTime.parse(params[:date]) : DateTime.now
  end


  private

  def get_layout
    'devise' unless current_user
  end
end
