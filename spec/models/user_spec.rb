describe User do

  before(:each) { @user = User.new(email: 'user@example.com') }

  subject { @user }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.email).to match 'user@example.com'
  end

  it "requires a first name" do
    user = User.new(firstname: "")
    
    expect(user.valid?).to eq(false)
    expect(user.errors[:firstname].any?).to eq(true)
  end

  it "requires a last name" do
    user = User.new(lastname: "")
    
    expect(user.valid?).to eq(false)
    expect(user.errors[:lastname].any?).to eq(true)
  end

  it "requires a role" do
    user = User.new(firstname: "Usie", lastname: "Userson", role: nil)

    expect(user.valid?).to eq(false)
    expect(user.errors[:role].any?).to eq(true)
  end

end
