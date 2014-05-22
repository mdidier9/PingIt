require 'spec_helper'

describe User do
  it { should have_many(:created_pingas) }
  it { should have_many(:user_pingas) }
  it { should have_many(:pingas).through(:user_pingas) }
end
