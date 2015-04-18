include Warden::Test::Helpers
Warden.test_mode!

feature 'User profile page', :devise do

  after(:each) do
    Warden.test_reset!
  end

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
    expect(page).to have_content "User First name: Usie Last name: Userson"
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
