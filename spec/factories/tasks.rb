FactoryBot.define do
    factory :task do
        title { 'title1' }
        content { 'title1_content' }
        id {1}
        expired_at{'2021/02/19'}
        status{2} #{ 未了: 0, 対応中: 1, 完了: 2 }
      end

      factory :second_task, class: Task do
        title { 'title2' }
        content { 'title2_content' }
        id{2}
        expired_at{'2021/02/01'}
        status{0} #{ 未了: 0, 対応中: 1, 完了: 2 }
      end
end
