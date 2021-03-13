require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  let(:user) { build_stubbed(:user) }

  it 'for not matching ending' do
    user.online_at = DateTime.now - 15.days
    expect(helper.last_seen(user)).to eq(content_tag(:small, 'заходил 15 дней назад', class: 'text-muted'))
  end

  it 'for online users' do
    user.online_at = DateTime.now
    expect(helper.last_seen(user)).to eq(content_tag(:span, 'онлайн', class: 'badge badge-success'))
  end
end
