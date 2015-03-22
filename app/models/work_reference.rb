class WorkReference < ActiveRecord::Base
  belongs_to :employer_user
  belongs_to :worker_user
end
