class WorkReference < ActiveRecord::Base
  belongs_to :employer_user, class_name: "User"
  belongs_to :worker_user, class_name: "User"

  validates :work, presence: true
  validates :comment, presence: true

end
