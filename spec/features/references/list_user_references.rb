describe "Given a user called Workerman with a reference from another user called Employenator" do
  before do
    @employenator = FactoryGirl.create(:user,
                                role: 'employer',
                                name: "Employenator",
                                email: "employ@enator.com")


    @workerman = User.create!(user_attributes(name: "Kenwin",   email: "kenwin@example.com"))
    @workerman = FactoryGirl.create(:user,
                                role: 'worker',
                                name: "Workerman",
                                email: "worker@working.com")

    @review = Review.create work: 'IT', comment: 'The best IT work ever!!!', reviewed: @workerman, reference: @employenator
  end

  describe 'when users gives reviews to a user it lists the reviews on their profile page' do

    it "lists reviews" do

      sign_in(@employenator)

      visit user_url(@workerman)

      expect(page).to have_text(@review.work)
      expect(page).to have_text(@review.comment)
    end
  end
end
