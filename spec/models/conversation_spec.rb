require 'spec_helper'

describe Conversation do
	describe "Associations" do
		[ :participants, :conversation_items ].each do |assocations|
			it { should have_many assocations }
		end
	end
end
