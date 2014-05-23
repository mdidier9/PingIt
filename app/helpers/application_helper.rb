module ApplicationHelper
	def start_time(pinga)
		if pinga.start_time > Time.now
			return "starts in #{distance_of_time_in_words(Time.now, pinga.start_time)}"
		else
			return "Already started.  Hurry Up!"
		end
	end
end
