require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  before do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    @task1 = FactoryBot.create(:task)
    @task2 = FactoryBot.create(:second_task)
  end
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: nil, content: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗テスト', content: nil)
        expect(task).not_to be_valid
        #task = Task.new(title: nil)
        #task.valid?
        #expect(title.errors[:title]).to include("can't be blank")
        # ここに内容を記載する
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '成功title', content: "成功content")
        #visit task_path(task.id)
        #expect(task).to has_content '成功title'
        expect(task).to be_valid
        #expect(page).to have_content 'title2'
        # ここに内容を記載する
      end
    end
  end
  describe '検索機能' do
    # 必要に応じて、テストデータの内容を変更して構わない
    # let!(:task) { FactoryBot.create(:task, title: 'task') }
    # let!(:second_task) { FactoryBot.create(:second_task, title: "sample") }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
        expect(Task.title_search('1')).to include(@task1)
        expect(Task.title_search('1')).not_to include(@task2)
        expect(Task.title_search('1').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに内容を記載する
        expect(Task.status_search('未了')).to include(@task2)
        expect(Task.status_search('未了')).not_to include(@task1)
        expect(Task.status_search('未了').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        # ここに内容を記載する
        expect(Task.status_search('未了').title_search('title')).to include(@task2)
        expect(Task.status_search('未了').title_search('title')).not_to include(@task1)
        expect([Task.status_search('未了').title_search('title')].count).to eq 1
      end
    end
  end
end
