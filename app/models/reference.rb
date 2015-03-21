class Reference < ActiveRecord::Base
  belongs_to :employer_user, class_name: "User"
  belongs_to :worker_user, class_name: "User"
end
