require 'rails_helper'

RSpec.describe SubfilesController, type: :controller do
  let(:substrate) { create(:substrate) }
  let!(:subfile)  { create(:subfile, substrate: substrate) }

  %i[admin from_lab182].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'returns new' do
        expect(@ability.can? :new, Subfile).to be true
        get :new, params: { substrate_id: substrate }
        expect(response).to render_template(:new)
      end

      it 'not creates a new Subfile' do
        expect(@ability.can? :create, Subfile).to be true
        expect{ post :create, params: { substrate_id: substrate ,subfile: attributes_for(:subfile) } }.to change(Subfile, :count).by(1)
        expect(response).to redirect_to(assigns(:substrate))
      end

      it 'not creates a new Subfile' do
        expect(@ability.can? :create, Subfile).to be true
        expect{ post :create, params: { substrate_id: substrate ,subfile: attributes_for(:subfile) } }.to change(Subfile, :count).by(1)
        expect(response).to redirect_to(assigns(:substrate))
      end

      it 'destroys' do
        expect(@ability.can? :destroy, subfile).to be true
        expect{ delete :destroy, params: { substrate_id: substrate, id: subfile }, format: 'js', xhr: true }.to change(Subfile, :count).by(-1)
      end
    end
  end

  describe 'user should' do
    login_user(:user)

    it 'not returns new' do
      expect(@ability.cannot? :new, Subfile).to be true
      expect{ get :new, params: { substrate_id: substrate } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not creates a new Subfile' do
      expect(@ability.cannot? :create, Subfile).to be true
      expect{ post :create, params: { substrate_id: substrate, subfile: attributes_for(:subfile) } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Subfile, :count).by(0)
    end

    it 'not destroy' do
      expect(@ability.cannot? :destroy, subfile).to be true
      expect{ delete :destroy, params: { substrate_id: substrate, id: subfile }, format: 'js', xhr: true }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Subfile, :count).by(0)
    end
  end

  describe 'unreg user should' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it 'returns new' do
      get :new, params: { substrate_id: substrate }
    end

    it 'creates a new Subfile' do
      post :create, params: { substrate_id: substrate, subfile: attributes_for(:subfile) }
      expect{ response }.to change(Subfile, :count).by(0)
    end

    it 'not destroy' do
      delete :destroy, params: { substrate_id: substrate, id: subfile }, format: 'js', xhr: true
      expect{ response }.to change(Subfile, :count).by(0)
    end
  end
end
