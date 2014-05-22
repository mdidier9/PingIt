require 'spec_helper'

describe UserPinga do
  it { should belong_to(:pinga) }
  it { should belong_to(:user) }
end
