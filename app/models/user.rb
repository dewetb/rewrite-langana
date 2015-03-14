class User < ActiveRecord::Base
  enum role: [:worker, :employer, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  validates :firstname, presence: true
  validates :lastname, presence: true

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
