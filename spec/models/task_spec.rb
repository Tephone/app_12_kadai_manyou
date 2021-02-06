require 'rails_helper'
describe 'タスクモデル機能', type: :model do
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
end
