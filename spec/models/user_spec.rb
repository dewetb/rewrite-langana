describe User do

  before(:each) { @user = User.new(email: 'user@example.com') }

  subject { @user }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.email).to match 'user@example.com'
  end

  it "requires a name" do
    user = User.new(name: "")
    
    expect(user.valid?).to eq(false)
    expect(user.errors[:name].any?).to eq(true)
  end

end
