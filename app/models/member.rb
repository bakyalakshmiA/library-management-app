class Member < ApplicationRecord
    validates :name, presence: { message: "name must be given" }
    validates :email, uniqueness: true, presence: { message: "email must be given please" }
    validates :phone_number, presence: { message: "phone_number must be given please" }
end