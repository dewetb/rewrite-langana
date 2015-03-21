FactoryGirl.define do
  factory :reference do
    employer_user nil
worker_user nil
work "MyString"
comment "MyText"
rating 1
recommend false
  end

end
