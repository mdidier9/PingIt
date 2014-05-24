module ApplicationHelper
	def start_time(pinga)
			"in #{distance_of_time_in_words(Time.now, pinga.start_time)}"
	end
end
