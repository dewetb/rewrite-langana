describe "Creating a new work reference" do
  it "saves the reference and shows the reference on the user's detail page" do
    user1 = FactoryGirl.create(:user, role: 'employer')
    user2 = FactoryGirl.create(:user,
                        role: 'worker',
                        firstname: "Jeremy",
                        lastname: "Ramos",
                        email: "other@example.com"
                      )

    login_as(user1, :scope => :user)

    visit user_path(user2)

    click_button 'Give Reference'

    expect(current_path).to eq(new_user_work_reference_path(user2))

    fill_in "What work did #{user2.firstname} do for you?", with: "#{user2.firstname} fixed my computer"

    fill_in "Comment", with: "They installed more ram, reinstalled my OS and restored all of my data. I could not be happier"

    click_button 'Save Reference'

    expect(current_path).to eq(user_path(user2))

    expect(page).to have_text("Thanks for giving a reference!")
    expect(page).to have_text("They installed more ram")
  end

  it "does not save the reference if it's invalid" do
    user1 = FactoryGirl.create(:user, role: 'employer')
    user2 = FactoryGirl.create(:user,
                        role: 'worker',
                        firstname: "Jeremy",
                        lastname: "Ramos",
                        email: "other@example.com"
                      )


    login_as(user1, :scope => :user)

    visit user_path(user2)

    click_button 'Give Reference'

    expect {
      click_button 'Save Reference'
    }.not_to change(WorkReference, :count)

    expect(page).to have_text('error')
  end
end
