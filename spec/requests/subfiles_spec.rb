require 'rails_helper'

RSpec.describe 'Subfiles', type: :request do
  let(:substrate) { create(:substrate) }
  let!(:subfile)  { create(:subfile, substrate: substrate) }

  %i[admin from_lab182].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'returns new' do
        expect(@ability.can? :new, Subfile).to be true
        get new_substrate_subfile_path(substrate)
        expect(response).to render_template(:new)
      end

      it 'destroys' do
        expect(@ability.can? :destroy, subfile).to be true
        expect{ delete substrate_subfile_path(substrate, subfile), xhr: true }.to change(Subfile, :count).by(-1)
      end
    end
  end

  describe 'user should' do
    login_user(:user)

    it 'not returns new' do
      expect(@ability.cannot? :new, Subfile).to be true
      expect{ get new_substrate_subfile_path(substrate) }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not destroy' do
      expect(@ability.cannot? :destroy, subfile).to be true
      expect{ delete substrate_subfile_path(substrate, subfile), xhr: true }
        .to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Subfile, :count).by(0)
    end
  end

  describe 'unreg user should' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it 'returns new' do
      get new_substrate_subfile_path(substrate)
    end

    it 'not destroy' do
      delete substrate_subfile_path(substrate, subfile), xhr: true
      expect{ response }.to change(Subfile, :count).by(0)
    end
  end
end
