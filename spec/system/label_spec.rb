require 'rails_helper'
RSpec.describe 'ラベル関連機能', type: :system do
  before do
    
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    user = FactoryBot.create(:user)
    @task1 = FactoryBot.create(:task, user_id: user.id)
    @task2 = FactoryBot.create(:second_task, user_id: user.id)
    #binding.pry
    FactoryBot.create(:tag)
    FactoryBot.create(:tag2)

    visit new_session_path
     fill_in 'Email', with: 'one@example.com'
     fill_in 'Password', with: 'aaaaaa'
     click_on 'Log in'
    
  end
  describe 'index' do
    it 'ラベル検索機能' do
      visit edit_task_path(@task1.id)
      check 'sample1'
      click_on '更新する'
      visit tasks_path
      select(value = 'sample1')
      #binding.pry
      click_on 'tag-search'
      #binding.pry
      expect(page).to have_content 'title1'
      expect(page).to_not have_content 'title2'
    end
  end
  describe 'new/edit/show' do
    it 'タスク新規登録時にラベルを複数登録/詳細画面にラベル一覧を表示' do
        visit new_task_path
        #binding.pry
        fill_in 'Title',with: 'test'
        fill_in 'Content',with: 'test_content'
        fill_in  'Expired at',with: '2021-02-19-00:00:00'
        select( value = '完了')
        check 'sample1' and check 'sample2'
        click_on '登録する'
        visit task_path(Task.last.id)
        #binding.pry
        expect(page).to have_content 'sample1'
        expect(page).to have_content 'sample2'
    end
    it 'タスク編集時にラベルも編集' do
      visit edit_task_path(@task1.id)
      check 'sample1'
      click_on '更新する'
      visit task_path(@task1.id)
      #binding.pry
      expect(page).to have_content 'sample1'
    end 
   end
   
end