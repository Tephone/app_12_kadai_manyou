FactoryBot.define do
    factory :task do
        title { 'title1' }
        content { 'title1_content' }
      end
      # 作成するテストデータの名前を「second_task」とします
      # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
      factory :second_task, class: Task do
        title { 'title2' }
        content { 'title2_content' }
      end
end
