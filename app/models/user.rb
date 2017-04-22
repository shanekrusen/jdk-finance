class User < ApplicationRecord
  attr_accessor :phone
  validates :phone, :length => { :is => 10 }
  validates :phone, presence: true
  validates :password, :length => { :is => 4 }
  validates :password, :numericality => true


  has_many :incomes
  has_many :categories
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
