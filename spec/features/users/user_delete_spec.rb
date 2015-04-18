include Warden::Test::Helpers
Warden.test_mode!

#the following line used to have :devise, :js do', would like to learn why
feature 'User delete', :devise do

  after(:each) do
    Warden.test_reset!
  end

  scenario 'user can delete own account' do
    skip 'skip a slow test'
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit edit_user_registration_path(user)
    click_button 'Cancel my account'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content I18n.t 'devise.registrations.destroyed'
  end

  scenario "user can not delete another's account" do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user, email: 'user2@example.com')
    login_as(user1, :scope => :user)
    Capybara.current_session.driver.header 'Referer', root_path
    visit users_path(user2)
    click_button 'Delete Account'
    expect(page).to have_content "Not allowed"
  end

end




