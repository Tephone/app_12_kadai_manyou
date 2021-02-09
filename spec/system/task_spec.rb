require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
     @task1 = FactoryBot.create(:task)
     @task2 = FactoryBot.create(:second_task)
    # @task1 = let(:task) { FactoryBot.create(:task) }
    # @task2 = let(:second_task) { FactoryBot.create(:second_task) }
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'Title',with: 'test3'
        fill_in 'Content',with: 'test3_content'
        fill_in  'Expired at',with: '2021-02-19-00:00:00'
        #fill_in 'Status',with: 2
        select( value = '完了')
        click_on '登録する'
        #visit task_path
        expect(page).to have_content 'test3'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        #task = FactoryBot.create(:task, title: 'title1')
        visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'title1'
        expect(page).to have_content 'title2'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        # ここに実装する
        #Task.create(id: 1, title: "task3", content: "task3_content")
        #Task.create(id: 2, title: "task4", content: "task4_content")
        visit tasks_path
        task = Task.all.order(id: :desc)
        expect(task[0].id).to have_content '2'
        expect(task[1].id).to have_content '1'
      end
    end
    context 'タスクが期日の降順で並んでいる場合' do
      it '期日に最も余裕のあるものが一番上に表示される' do
        visit tasks_path
        click_on '終了期限(降順)でソートする'
        task = Task.all.order(expired_at: :desc)
        expect(task[0].expired_at).to have_content '2021-02-19 00:00:00 +0900'
        expect(task[1].expired_at).to have_content '2021-02-01 00:00:00 +0900'
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
  describe 'タスク管理機能', type: :system do
    describe '検索機能' do
      # before do
      #   # 必要に応じて、テストデータの内容を変更して構わない
      #   FactoryBot.create(:task, title: "task")
      #   FactoryBot.create(:second_task, title: "sample")
      # end
      context 'タイトルであいまい検索をした場合' do
        it "検索キーワードを含むタスクで絞り込まれる" do
          visit tasks_path
          fill_in 'title_search', with: '1'
          click_on 'search'
          expect(page).to have_content 'title1'
          expect(page).to_not have_content 'title2'

          # タスクの検索欄に検索ワードを入力する (例: task)
          # 検索ボタンを押す
          #expect(page).to have_content 'task'
        end
      end
      context 'ステータス検索をした場合' do
        it "ステータスに完全一致するタスクが絞り込まれる" do
          visit tasks_path
          select(value = '未了')
          click_on 'search'
          expect(page).to have_content 'title2'
          expect(page).to_not have_content 'title1'
          #binding.pry
          # ここに実装する
          # プルダウンを選択する「select」について調べてみること
        end
      end
      context 'タイトルのあいまい検索とステータス検索をした場合' do
        it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
          # ここに実装する
          visit tasks_path
          fill_in 'title_search', with: 'title'
          select(value = '未了')
          click_on 'search'
          expect(page).to have_content 'title2'
          expect(page).to_not have_content 'title1'
        end
      end
    end
  end
end