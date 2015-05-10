class User < ActiveRecord::Base
  has_many :work_references, foreign_key: :worker_user_id
  has_many :work_references_given, class_name: "WorkReference", foreign_key: :employer_user_id

#  has_many :employer_references, foreign_key: :worker_user_id
#  has_many :employer_references_given, class_name: "EmployerReferences", foreign_key: :employer_user_id

  enum role: [:worker, :employer, :vip, :admin]

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :role, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :workers, -> { where(role: 'worker')}
  scope :employers, -> { where(role: 'employer')}

end
