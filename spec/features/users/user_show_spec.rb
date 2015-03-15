include Warden::Test::Helpers
Warden.test_mode!

# Feature: User profile page
#   As a user
#   I want to visit my user profile page
#   So I can see my personal account data
feature 'User profile page', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User sees own profile
  #   Given I am signed in
  #   When I visit the user profile page
  #   Then I see my own email address
  scenario 'user sees own profile' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit user_path(user)
    expect(page).to have_content 'User'
    expect(page).to have_content user.email
  end

  scenario "employer can see a worker's page if he is logged in" do
    me = FactoryGirl.create(:user, role: 'employer')
    other = FactoryGirl.create(:user, role: 'worker', email: 'other@example.com')
    login_as(me, :scope => :user)
    Capybara.current_session.driver.header 'Referer', root_path
    visit user_path(other)
    expect(page).to have_content "Other user's name"
  end

  scenario "users cannot see a worker's page when not logged in" do
    user = FactoryGirl.create(:user, role: 'worker')
    visit user_path(user)
    expect(page).to have_content "You need to sign in or sign up before continuing"
  end

  scenario "users cannot see a employer's page when not logged in" do
    user = FactoryGirl.create(:user, role: 'employer')
    visit user_path(user)
    expect(page).to have_content "You need to sign in or sign up before continuing"
  end


  scenario "employer cannot see an employer's page when logged in" do
    me = FactoryGirl.create(:user, role: 'employer')
    other = FactoryGirl.create(:user, role: 'employer', email: 'other@example.com')
    login_as(me, :scope => :user)
    Capybara.current_session.driver.header 'Referer', root_path
    visit user_path(other)
    expect(page).to have_content 'Access denied.'
  end

  scenario "worker cannot see an employer's page when logged in" do
    me = FactoryGirl.create(:user, role: 'worker')
    other = FactoryGirl.create(:user, role: 'employer', email: 'other@example.com')
    login_as(me, :scope => :user)
    Capybara.current_session.driver.header 'Referer', root_path
    visit user_path(other)
    expect(page).to have_content 'Access denied.'
  end

  scenario "worker cannot see a worker's page when logged in" do
    me = FactoryGirl.create(:user, role: 'worker')
    other = FactoryGirl.create(:user, role: 'worker', email: 'other@example.com')
    login_as(me, :scope => :user)
    Capybara.current_session.driver.header 'Referer', root_path
    visit user_path(other)
    expect(page).to have_content 'Access denied.'
  end
  
end
