require 'spec_helper'

describe Category do
	context "category associations" do
	  it { should have_many(:pingas) }
	  it { should have_many(:user_categories)}
	  it { should have_many(:users).through(:user_categories)}
	end

end
