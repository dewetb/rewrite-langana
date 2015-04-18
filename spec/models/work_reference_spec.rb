require 'rails_helper'

RSpec.describe WorkReference, type: :model do
  it "requires the work to be named" do
    workref = WorkReference.new(work: "")

    expect(workref.valid?).to eq(false)
    expect(workref.errors[:work].any?).to eq(true)
  end

end
