FactoryGirl.define do
  factory :user_pinga

  	after_build do |user_pinga|
  		FactoryGirl.create(:user, user_pinga: user_pinga)
 			FactoryGirl.create(:pinga, user_pinga: user_pinga)
		end	
	end

  factory :user do
  	user_pinga nil
  end

  factory :pinga do
  	user_pinga nil
  end


end