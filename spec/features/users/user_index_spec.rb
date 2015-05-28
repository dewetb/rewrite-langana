include Warden::Test::Helpers
Warden.test_mode!

# Feature: User index page
#   As a user
#   I want to see a list of users
#   So I can see who has registered
feature 'User index page', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User listed on index page
  #   Given I am signed in
  #   When I visit the user index page
  #   Then I see my own email address
  scenario 'user sees index of workers only' do
    user = FactoryGirl.create(:user)
    employuser = FactoryGirl.create(:user,
                          role: 'employer',
                          email: 'employ@example.com',
                          firstname: 'Emmie',
			  phone: "8888888")
    workuser = FactoryGirl.create(:user,
                          role: 'worker',
                          email: 'work@example.com',
                          firstname: 'Workie',
			  phone: "3333333")
    login_as(user, scope: :user)
    visit users_path
    expect(page).to have_content workuser.firstname
    expect(page).not_to have_content employuser.firstname
  end

end
