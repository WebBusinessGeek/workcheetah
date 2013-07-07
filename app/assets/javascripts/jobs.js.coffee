# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	# Endless page
	if $('.pagination').length
		$(window).scroll ->
			url = $('.pagination .next_page').attr('href')
			if url && $(window).scrollTop() > $(document).height() - $(window).height() - 150
				$('.pagination').text("Fetching more jobs...")
				$.getScript(url)

		# Trigger window scroll in case user's browser is so big it displays all results at once and has to fetch the next results already then
		$(window).scroll