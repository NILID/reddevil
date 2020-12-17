require 'rails_helper'

RSpec.describe SubfilesController, type: :controller do
  let(:substrate) { create(:substrate) }
  let!(:subfile)  { create(:subfile, substrate: substrate) }

  %i[admin from_lab182].each do |role|
    describe "#{role} should" do
      login_user(role)
      it 'creates a new Subfile' do
        expect(@ability.can? :create, Subfile).to be true
        expect{ post :create, params: { substrate_id: substrate, subfile: attributes_for(:subfile) } }.to change(Subfile, :count).by(1)
        expect(response).to redirect_to(assigns(:substrate))
      end
    end
  end

  describe 'user should' do
    login_user(:user)

    it 'not creates a new Subfile' do
      expect(@ability.cannot? :create, Subfile).to be true
      expect{ post :create, params: { substrate_id: substrate, subfile: attributes_for(:subfile) } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Subfile, :count).by(0)
    end
  end

  describe 'unreg user should' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it 'creates a new Subfile' do
      post :create, params: { substrate_id: substrate, subfile: attributes_for(:subfile) }
      expect{ response }.to change(Subfile, :count).by(0)
    end
  end
end
