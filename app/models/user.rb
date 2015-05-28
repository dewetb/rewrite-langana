class User < ActiveRecord::Base
  has_many :work_references, foreign_key: :worker_user_id
  has_many :work_references_given, class_name: "WorkReference", foreign_key: :employer_user_id
  mount_uploader :profile_picture, ProfilePictureUploader

#  has_many :employer_references, foreign_key: :worker_user_id
#  has_many :employer_references_given, class_name: "EmployerReferences", foreign_key: :employer_user_id

  enum role: [:worker, :employer, :vip, :admin]

  validates_presence_of :firstname, :lastname, :role
  validates_presence_of :email, unless: ->(user){user.phone.present?}
  validates_presence_of :phone, unless: ->(user){user.email.present?}
  validates_uniqueness_of :phone


  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :workers, -> { where(role: 'worker')}
  scope :employers, -> { where(role: 'employer')}

end
