class User < ApplicationRecord
    has_many :tasks, dependent: :destroy
    validates :name,  presence: true, length: { maximum: 30 }
    validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    before_validation { email.downcase! }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
    #enum admin: { 無: false, 有: true }
    before_destroy :not_destroy_by_self
    before_update :not_destroy_by_self
    private
    def not_destroy_by_self
        if self.admin && User.where(admin: true).count == 1
            throw(:abort)
        end
    end
    # def not_update_by_self
    #     if self.admin && User.where(admin: true).count < 2
    #         # if admin == false
    #         #     throw(:abort)
    #         # end
    #     end
    # end
    # before_destroy :not_destroy_by_self, only: %i[ update destroy ]
 
            

end
