class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new(account: Account.new) # guest user (not logged in)

    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities

    if user.admin?
      can :manage, :all
    end

    if user.account
      can :manage, Job, account_id: user.account.id
      can :read, JobApplication, applicant_access: { account_id: user.account.id }
    end

    can :manage, VideoChat do |video_chat| video_chat_managable?(video_chat, user) end

    if !user.admin?
      cannot :manage, Tweet
    end
  end

  def video_chat_managable?(video_chat, user)
    user == video_chat.requester || user == video_chat.recipient || video_chat.new_record?
  end
end
