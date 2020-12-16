module ForecastsHelper
  def ending_style(forecast, ending)
    check_ending = forecast&.ending == ending ? 'active current' : nil
    check_penalty = forecast.team1goal != forecast.team2goal && ending == 'penalty' ? 'disabled' : nil
    "#{check_ending} label-#{ending} #{check_penalty}".strip
  end
end
