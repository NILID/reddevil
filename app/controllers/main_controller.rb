class MainController < ApplicationController
  layout "main"

  def index
    @messages=Message.where(close: false)
    @bduser=Member.find_births_for(Time.now, Time.now + 1.month)
    @bdusers_today=@bduser.birth_today.group_by {|u| [u.birth.strftime("%m"), u.birth.strftime("%d")]}
    now=DateTime.now
    tomorrow=DateTime.tomorrow
    yesterday=DateTime.yesterday
    @bdusers_yesterday=Member.find_births_for(yesterday).group_by {|u| [u.birth.strftime("%m"), u.birth.strftime("%d")]}
    @bdusers_prevyesterday=Member.find_births_for(yesterday - 1.day).group_by {|u| [u.birth.strftime("%m"), u.birth.strftime("%d")]}
    @bdusers_tomorrow=@bduser.find_births_for(tomorrow).group_by {|u| [u.birth.strftime("%m"), u.birth.strftime("%d")]}
    @bdusers_month=@bduser.find_births_for(tomorrow + 1.day, now + 1.month).group_by {|u| [u.birth.strftime("%m"), u.birth.strftime("%d")]}
    @holidays_today=Holidays.on(now, :ru)
    @holidays_tomorrow=Holidays.on(tomorrow, :ru)
    @docs=Doc.order("created_at desc").limit(5)
  end

  def mirror
    @item=Item.find(params[:m]) if params[:m] && Item.find_by_id(params[:m])
    @mirrors=Mirror.all
  end

end
