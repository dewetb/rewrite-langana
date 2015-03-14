class User < ActiveRecord::Base
  enum role: [:worker, :employer, :vip, :admin]

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :role, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
