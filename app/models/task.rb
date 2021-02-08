class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  enum status: { 未了: 0, 対応中: 1, 完了: 2 }
  enum priority: { 低: 0, 中: 1, 高: 2 }

  scope :title_search, -> (title) { where('title LIKE ?', "%#{title}%")}
  scope :status_search, -> (status) { where(status: status)}
  
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
