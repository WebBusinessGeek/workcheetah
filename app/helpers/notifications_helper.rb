module NotificationsHelper
	def link_to_notification notification, args = {}
		if !notification.has_notifiable?
			return notification.body
		else
			notifiable = notification.notifiable
			if notifiable.is_a? ConversationItem
				destination = notifiable.conversation
			elsif notifiable.is_a? VideoChat
				destination = notifiable
			elsif notifiable.is_a? Job
				destination = notifiable
			elsif notifiable.is_a? JobApplication
				destination = notifiable
			end

			return link_to notification.body, destination, args
		end
	end
end