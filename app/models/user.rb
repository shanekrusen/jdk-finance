class User < ApplicationRecord
    has_many :incomes
    has_many :categories
    attr_accessor :pin
    NUMERICAL_REGEX = /\A[0-9]*\z/
    validates :phone_number, :presence => true, :uniqueness => :true, :length => { :is => 10 }, :format => NUMERICAL_REGEX
    validates :pin, :confirmation => :true
    validates :pin, :format => NUMERICAL_REGEX, :length => { :is => 4 }, :on => create
    before_save :encrypt_pin
    after_save :clear_pin

    def encrypt_pin
        if pin.present?
            self.salt = BCrypt::Engine.generate_salt
            self.encrypted_pin = BCrypt::Engine.hash_secret(pin, salt)
        end
    end

    def clear_pin
        self.pin = nil
    end

    def self.authenticate(login_phone="", login_pin="")
        user = User.find_by_phone_number(login_phone)
        if user && user.match_pin(login_pin)
            return user
        else
            return false
        end
    end

    def match_pin(login_pin="")
        encrypted_pin == BCrypt::Engine.hash_secret(login_pin, salt)
    end
end
