class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true
  enum status: { 未了: 0, 対応中: 1, 完了: 2 }
  enum priority: { 低: 0, 中: 1, 高: 2 }

  #scope :title_search, -> (title) { where('title LIKE ?', "%#{title}%")} titleは引数（パラメーターで受け取った値がここに入る）
  scope :status_search, -> (status) { where(status: status)} #statusは引数（パラメーターで受け取った値がここに入る）
  
  scope :title_search, -> (title) do  #scopeはメゾットで、title_searchは設定したメゾット名
    where('title LIKE ?', "%#{title}%")
  end
  # def self.search(search_word)
  #   search_word ? where('title LIKE ?', "%#{search_word}%") : all
  #   #search_word ? where("%#{search_word}%") : all
  #   #search_word ? where('title LIKE ? AND status', "%#{search}%", "%#{search}%") :all
  #   #scopeでまとめる？
  # end
  # # def self.search2(search_word)
  # #   search_word ? where('status LIKE ?', "%#{search_word}%") : all
  # # end

  
end
