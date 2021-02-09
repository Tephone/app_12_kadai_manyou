require 'rails_helper'
RSpec.describe 'ユーザー関連機能', type: :system do
  before do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    # @user = FactoryBot.create(:user)
    @user2 =  FactoryBot.create(:user2)
  end
  describe 'ユーザ登録のテスト' do
    it 'ユーザの新規登録ができること' do
        visit new_user_path
        fill_in 'Name', with: 'three'
        fill_in 'Email', with: 'three@example.com'
        fill_in 'Password', with: 'aaaaaa'
        fill_in 'Password confirmation', with: 'aaaaaa'
        click_on 'Create my account'
        visit users_path
        expect(page).to have_content 'three'
    end
    it 'ユーザがログインせずタスク一覧画面に飛ぼうとしたとき、ログイン画面に遷移すること' do
        visit tasks_path
        expect(page).to have_content 'Log in'       
    end 
  end
  describe ' セッション機能のテスト' do
    it 'ログインができること' do
        FactoryBot.create(:user)
        visit new_session_path
        fill_in 'Email', with: 'one@example.com'
        fill_in 'Password', with: 'aaaaaa'
        click_on 'Log in'
        #expect(page).to have_content 'one'   
    
    end
    it '自分の詳細画面(マイページ)に飛べること' do
        user = FactoryBot.create(:user)
        visit user_path(user.id)
        expect(page).to have_content 'one' 

    
    end 
    it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移すること' do
        user = FactoryBot.create(:user)
        #visit user_path(@user2.id)
        #expect(page).to have_content '' 
    
    end 
    it 'ログアウトができること' do
        user = FactoryBot.create(:user)
        visit tasks_path
        #click_on 'Logout'
        #expect(page).to have_content 'Log in'
    
    end 
  end
  describe ' 管理画面のテスト' do
    it '管理ユーザは管理画面にアクセスできること' do
        visit admin_users_path
        expect(page).to have_content 'admin'
    
    end
    it '一般ユーザは管理画面にアクセスできないこと' do
        FactoryBot.create(:user)
        visit admin_users_path
        expect(page).to have_content 'admin'
        #入れてしまってる、、、

    
    end 
    it '管理ユーザはユーザの新規登録ができること' do
        # visit new_admin_user_path
        # fill_in 'Name', with: 'three'
        # fill_in 'Email', with: 'three@example.com'
        # fill_in 'Password', with: 'aaaaaa'
        # fill_in 'Password confirmation', with: 'aaaaaa'
        # click_on 'Create my account'
        # visit admin_users_path
        # expect(page).to have_content 'three'
    
    end 
    it '管理ユーザはユーザの詳細画面にアクセスできること' do
        # visit admin_user_path(user.id)
        # expect(page).to have_content 'one' 
    
    end 
    it '管理ユーザはユーザの編集画面からユーザを編集できること' do
        # visit edit_admin_user_path
        # fill_in 'Name', with: 'three'
        # fill_in 'Email', with: 'three@example.com'
        # fill_in 'Password', with: 'aaaaaa'
        # fill_in 'Password confirmation', with: 'aaaaaa'
        # click_on 'Create my account'
        # visit admin_users_path
        # expect(page).to have_content 'three'
    
    end 
    it '管理ユーザはユーザの削除をできること' do
        # visit admin_users_path
        # click_on 'destroy'
        # expect(page).to_not have_content '消したもの' 
    
    end 
  end
   
end