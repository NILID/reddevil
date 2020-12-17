require 'rails_helper'

RSpec.describe 'Positions', type: :request do
  let!(:user)     { create(:user) }
  let!(:member)   { create(:member, user: user) }
  let!(:position) { create(:position, member: member) }

  describe 'admin should' do
    login_user(:admin)

    it 'returns edit' do
      expect(@ability.can? :edit, position).to be true
      get edit_member_position_path(member, position)
      expect(response).to render_template(:edit)
    end

    it 'destroys the requested row' do
      expect(@ability.can? :destroy, position).to be true
      expect{ delete member_position_path(member, position) }.to change(Position, :count).by(-1)
      expect(response).to redirect_to([member, Position])
    end

    it 'updates the requested row' do
      expect(@ability.can? :update, position).to be true
      put member_position_path(member, position, position: { position: 'Combiner' } )
      position.reload
      expect(response).to redirect_to([member, Position])
    end

    it 'returns new' do
      expect(@ability.can? :new, member => Position).to be true
      get new_member_position_path(member)
      expect(response).to be_successful
    end
  end

  %i[admin user].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'returns index' do
        expect(@ability.can? :index, Position).to be true
        get member_positions_path(member)
        expect(response).to be_successful
        expect(response).to render_template(:index)
      end

      it 'returns index without search params' do
        expect(@ability.can? :career, Position).to be true
        get career_positions_path
        expect(response).to redirect_to(
          career_positions_path(q: { moved_at_gteq: Russian.strftime(DateTime.now.beginning_of_month, '%d.%m.%Y'),
                                     moved_at_lteq: Russian.strftime(DateTime.now.end_of_month,       '%d.%m.%Y') })
        )
      end

      it 'returns index with search params' do
        expect(@ability.can? :career, Position).to be true
        get career_positions_path, params: { q: { moved_at_gteq: '01.12.2020', moved_at_lteq: '31.12.2020' } }
        expect(response).to be_successful
        expect(response).to render_template(:career)
      end
    end
  end

  describe 'user should' do
    login_user(:user)

    it 'not returns edit' do
      expect(@ability.can? :edit, position).to be false
      expect{
        get edit_member_position_path(member, position)
      }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not destroys' do
      expect(@ability.can? :destroy, position).to be false
      expect{
        expect{ delete member_position_path(member, position) }.to change(Position, :count).by(0)
      }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not updates' do
      expect(@ability.can? :update, position).to be false
      expect{
        put member_position_path(member, position, position: { position: 'Combiner' } )
      }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not returns new' do
      expect(@ability.can? :new, member => Position).to be false
      expect{
        get new_member_position_path(member)
      }.to raise_error(CanCan:: AccessDenied)
    end
  end

  describe 'unreg user should' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it 'get index' do
      get member_positions_path(member)
    end

    it 'get career' do
      get career_positions_path
    end

    it 'returns edit' do
      get edit_member_position_path(member, position)
    end

    it 'destroys the requested row' do
      expect{ delete member_position_path(member, position) }.to change(Position, :count).by(0)
    end

    it 'updates the requested row' do
      put member_position_path(member, position, position: { position: 'Combiner' } )
    end

    it 'returns new' do
      get new_member_position_path(member)
    end
  end
end
