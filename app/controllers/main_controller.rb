class MainController < ApplicationController
  layout 'main'

  def index
    now       = Date.today
    tomorrow  = Date.tomorrow
    yesterday = Date.yesterday

    @messages = Message.where(close: false)

    @bduser                = Member.find_births_for(now, now + 30.days)
    @bdusers_yesterday     = Member.find_births_for(yesterday).group_by {|u| [u.birth.strftime("%m"), u.birth.strftime("%d")]}
    @bdusers_prevyesterday = Member.find_births_for(yesterday - 1.day).group_by {|u| [u.birth.strftime("%m"), u.birth.strftime("%d")]}

    @bdusers_today    = @bduser.birth_today.group_by {|u| [u.birth.strftime("%m"), u.birth.strftime("%d")]}
    @bdusers_tomorrow = @bduser.find_births_for(tomorrow).group_by {|u| [u.birth.strftime("%m"), u.birth.strftime("%d")]}
    @bdusers_month    = @bduser.find_births_for(tomorrow + 1.day, now + 30.days).group_by {|u| [(u.birth.month < DateTime.now.month ? 1 : 0), u.birth.strftime("%m"), u.birth.strftime("%d")]}

    @holidays_today    = Holidays.on(now, :ru)
    @holidays_tomorrow = Holidays.on(tomorrow, :ru)
    @docs = Doc.where(show_last_flag: true).order('created_at desc').limit(5)
  end

  def mirror
    @item = Item.find(params[:m]) if params[:m] && Item.where(id: params[:m]).first
    @mirrors = Mirror.all
  end
end
