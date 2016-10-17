class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)


    #everybody
    cannot [:manage, :read], Message
    can [:new, :create], Note
    cannot [:edit, :update], Profile
    cannot :read, Doc, category: {hidden: true}
    can :read, :all
    can :rebuild, Result
    cannot :read, [Art, Work, Forecast]

    if user.role? :user
      can [:new, :create], Note
      can :manage, [Song, Album]
      can [:edit, :update], Profile, user: {id: user.id}
      can :like, Song
      can :read, :all

      cannot [:read], Forecast
      can [:destroy, :edit, :update], Forecast do |f|
        (f.round.deadline > DateTime.now) && (f.tempuser.user_id == user.id)
      end
      can [:new, :create], Forecast, tempuser: {user_id: user.id}

      cannot :read, Doc, category: {hidden: true}
      can [:favorites, :list], Album
      cannot [:manage, :read], Message
    end

    ################# MODERATOR USER
    if user.role? :moderator
      can :manage, [Doc, Category]
      can [:new, :create], [Art, Note]
      can [:new, :create], Work, art: {closed?: false}
      can [:edit, :update, :destroy], Work, user: {id: user.id}, art: {closed?: false}
      can :manage, Source, work: {user_id: user.id}
    end

    if user.role? :editor
      can [:manage, :read], Message
    end

    if user.role? :admin
      cannot [:read], Forecast
      can [:read], Forecast do |f|
        (f.round.deadline < DateTime.now) || (f.tempuser.user_id == user.id)
      end

      can [:read, :manage], :all

      can :list, Album
      can :like, Song
      can :counted, Result
#      can :read, Material, groups_mask: user.groups_mask
      cannot [:edit, :update], Art do |art|
        art.closed?
      end
      can [:make_role], User
    end


    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/bryanrite/cancancan/wiki/Defining-Abilities
  end
end
