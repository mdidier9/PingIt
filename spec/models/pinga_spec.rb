require 'spec_helper'

describe Pinga do
  it { should belong_to(:creator) }
  it { should have_many(:user_pingas) }
  it { should have_many(:users).through(:user_pingas) }
end
