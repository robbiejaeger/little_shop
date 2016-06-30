require 'rails_helper'

RSpec.describe Cause, type: :model do
  it { should have_many(:causes_charities) }
  it { should have_many(:charities) }
  it { should have_many(:recipients) }

  scenario "creating a slug method" do
    cause = Cause.create(name: "cause 1")

    expect(cause.slug).to eq("cause-1")
  end
end
