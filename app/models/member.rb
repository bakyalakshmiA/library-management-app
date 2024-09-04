class Member < ApplicationRecord
    has_many :borrowed_books
    has_many :books, through: :borrowed_books

    before_validation :normalize_attributes

    def normalize_attributes
        self.email = email.strip.downcase if email.present?
        self.name = name.strip.downcase if name.present?
    end

    EMAIL_FORMAT = URI::MailTo::EMAIL_REGEXP
    PHONE_NUMBER_FORMAT = /\A([9]{1})([234789]{1})([0-9]{8})\z/

    validates :name, :email, presence: { message: Proc.new { |object, data| "#{data[:attribute].to_s} can't be blank" } }
    validates :email, format: { with: EMAIL_FORMAT, message: "must be a valid email address" }, uniqueness: { case_sensitive: false, message: "has already been taken" }
    validates :phone_number, format: { with: PHONE_NUMBER_FORMAT, message: "must be a valid phone number" }, uniqueness: { allow_blank: true, message: "This phone number is already in use. Please provide a different one" }
    validates :member_id, uniqueness: true

    before_create :set_random_member_id, :set_started_and_ended_at

    private

    def set_random_member_id
     self.member_id = generate_random_member_id
    end


    def set_started_and_ended_at
        self.started_at = Time.current
        self.ended_at = started_at + 1.year
    end


    def generate_random_member_id
     loop do
       random_id = rand(1000000..9999999)  # Generate a random 7-digit number
       break random_id unless Member.exists?(member_id: random_id)
     end
    end


end