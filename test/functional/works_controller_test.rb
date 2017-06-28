require 'test_helper'

class WorksControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @work = works(:one)
    @other_work = works(:two)
    @art = @work.art
    @closed_work = works(:closed_work)
    @closed_art = @closed_work.art

    @user = users(:da)
    @admin = users(:admin)
    @moder = users(:moder)
    @art_user = users(:art)
  end

  test 'check setup variables' do
    assert (@art.closed? == false)
    assert @closed_work.closed?
  end

  test 'should not get new' do
    get :new, art_id: @art
    assert_redirected_to new_user_session_url
  end

  test 'admin should not get new' do
    sign_in @admin
    ability = Ability.new(@admin)

    assert ability.cannot? :new, Work

    assert_raise(CanCan::AccessDenied) do
      get :new, art_id: @art
    end
  end

  test 'user should not get new' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :new, Work

    assert_raise(CanCan::AccessDenied) do
      get :new, art_id: @art
    end
  end

  test 'moder should not get new' do
    sign_in @moder
    ability = Ability.new(@moder)

    assert ability.cannot? :new, Work

    assert_raise(CanCan::AccessDenied) do
      get :new, art_id: @art
    end
  end

  test 'artuser should get new' do
    sign_in @art_user
    ability = Ability.new(@art_user)
    assert ability.can? :new, Work

    get :new, art_id: @art
    assert_response :success
  end

  test 'artuser should not get new for closed art' do
    sign_in @art_user
    ability = Ability.new(@art_user)
    assert ability.cannot? :new, [@closed_art, Work]

    assert_raise(CanCan::AccessDenied) do
      get :new, art_id: @closed_art
    end
  end


  test 'should not create work' do
    assert_difference('Work.count', 0) do
      post :create, art_id: @art, work: { desc: @work.desc }
    end

    assert_redirected_to new_user_session_url
  end

  test 'art_user should create work' do
    sign_in @art_user
    ability = Ability.new(@art_user)
    assert ability.can? :create, Work

    assert_difference('Work.count') do
      post :create, art_id: @art, work: { desc: @work.desc }
    end

    assert_redirected_to arts_path
  end

  test 'art_user should not create work' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :create, Work

    assert_raise(CanCan::AccessDenied) do
      assert_difference('Work.count', 0) do
        post :create, art_id: @art, work: { desc: @work.desc }
      end
    end
  end

  test 'admin should not create work' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.cannot? :create, Work

    assert_raise(CanCan::AccessDenied) do
      assert_difference('Work.count', 0) do
        post :create, art_id: @art, work: { desc: @work.desc }
      end
    end
  end

  test 'should not get edit' do
    get :edit, art_id: @art, id: @work
    assert_redirected_to new_user_session_url
  end

  test 'art user should get edit' do
    sign_in @art_user
    ability = Ability.new(@art_user)
    assert ability.can? :edit, @work

    get :edit, art_id: @art, id: @work
    assert_response :success
  end

  test 'art user should not get edit not own work' do
    sign_in @art_user
    ability = Ability.new(@art_user)
    assert ability.cannot? :edit, @other_work

    assert_raise(CanCan::AccessDenied) do
      get :edit, art_id: @other_work.art, id: @other_work
    end
  end

  test 'admin should not get edit' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.cannot? :edit, @work

    assert_raise(CanCan::AccessDenied) do
      get :edit, art_id: @art, id: @work
    end
  end

  test 'moder should not get edit' do
    sign_in @moder
    ability = Ability.new(@moder)
    assert ability.cannot? :edit, @work

    assert_raise(CanCan::AccessDenied) do
      get :edit, art_id: @art, id: @work
    end
  end

  test 'user should not get edit' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :edit, @work

    assert_raise(CanCan::AccessDenied) do
      get :edit, art_id: @art, id: @work
    end
  end

  test 'should not update work' do
    put :update, art_id: @art, id: @work, work: { desc: @work.desc }
    assert_redirected_to new_user_session_url
  end

  test 'art user should update work' do
    sign_in @art_user
    ability = Ability.new(@art_user)
    assert ability.can? :update, @work

    put :update, art_id: @art, id: @work, work: { desc: @work.desc }
    assert_redirected_to arts_path
  end

  test 'art user should not update not own work' do
    sign_in @art_user
    ability = Ability.new(@art_user)
    assert ability.cannot? :update, @other_work

    assert_raise(CanCan::AccessDenied) do
      put :update, art_id: @art, id: @other_work, work: { desc: @other_work.desc }
    end
  end


  test 'user should not update work' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :update, @work

    assert_raise(CanCan::AccessDenied) do
      put :update, art_id: @art, id: @work, work: { desc: @work.desc }
    end
  end

  test 'moder should not update work' do
    sign_in @moder
    ability = Ability.new(@moder)
    assert ability.cannot? :update, @work

    assert_raise(CanCan::AccessDenied) do
      put :update, art_id: @art, id: @work, work: { desc: @work.desc }
    end
  end

  test 'admin should not update work' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.cannot? :update, @work

    assert_raise(CanCan::AccessDenied) do
      put :update, art_id: @art, id: @work, work: { desc: @work.desc }
    end
  end

  test 'should not destroy work' do
    assert_difference('Work.count', 0) do
      delete :destroy, art_id: @art, id: @work
    end

    assert_redirected_to new_user_session_url
  end

  test 'art user should destroy work' do
    sign_in @art_user
    ability = Ability.new(@art_user)
    assert ability.can? :destroy, @work

    assert_difference('Work.count', -1) do
      delete :destroy, art_id: @art, id: @work
    end

    assert_redirected_to arts_path
  end

  test 'art user should not destroy not own work' do
    sign_in @art_user
    ability = Ability.new(@art_user)
    assert ability.cannot? :destroy, @other_work

    assert_raise(CanCan::AccessDenied) do
      assert_difference('Work.count', 0) do
        delete :destroy, art_id: @other_work.art, id: @other_work
      end
    end
  end


  test 'user should not destroy work' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :destroy, @work

    assert_raise(CanCan::AccessDenied) do
      assert_difference('Work.count', 0) do
        delete :destroy, art_id: @art, id: @work
      end
    end
  end

  test 'admin should not destroy work' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.cannot? :destroy, @work

    assert_raise(CanCan::AccessDenied) do
      assert_difference('Work.count', 0) do
        delete :destroy, art_id: @art, id: @work
      end
    end
  end

  test 'moder should not destroy work' do
    sign_in @moder
    ability = Ability.new(@moder)
    assert ability.cannot? :destroy, @work

    assert_raise(CanCan::AccessDenied) do
      assert_difference('Work.count', 0) do
        delete :destroy, art_id: @art, id: @work
      end
    end
  end
end
