require 'rails_helper'

RSpec.describe ForecastsHelper, type: :helper do
  let(:forecast) { build_stubbed(:forecast) }

  it 'for not matching ending' do
    forecast.ending = 'penalty'
    expect(helper.ending_style(forecast, 'basic')).to eq('label-basic')
  end

  it 'for current active ending' do
    expect(helper.ending_style(forecast, forecast.ending)).to eq('active current label-basic')
  end

  it 'for disabled' do
    forecast.ending = 'penalty'
    forecast.team1goal = 10
    forecast.team2goal = 1
    expect(helper.ending_style(forecast, 'penalty')).to eq('active current label-penalty disabled')
  end
end
