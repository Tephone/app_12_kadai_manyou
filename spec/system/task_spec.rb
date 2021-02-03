require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    @task1 = FactoryBot.create(:task)
    task2 = FactoryBot.create(:second_task)
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        #binding.pry
        fill_in 'Title',with: 'test3'
        fill_in 'Content',with: 'test3_content'
        # binding.pry
        click_on 'Create Task'
        #binding.pry
        # click_on 'content'
        #visit task_path
        expect(page).to have_content 'test3'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        #task = FactoryBot.create(:task, title: 'title1')
        # タスク一覧ページに遷移
        visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'title1'
        expect(page).to have_content 'title2'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        #task1 = FactoryBot.create(:task)
        visit task_path(@task1.id)
        expect(page).to have_content 'title1'
       end
     end
  end
end