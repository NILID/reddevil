class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)

    # everybody
    can :read, :all
    can %i[archive stat holidays], Member
    cannot %i[manage read], [Message, Folder, Dataset, Event]
    can %i[new create], Note
    # cannot :read, Doc, category: { hidden: true }
    can :rebuild, Result
    cannot :read, [Forecast, Song, Album, Round, Forecast, Type, User, Member, Vacation]

    if user.role? :admin
      can [:read], Forecast do |f|
        (f.round.deadline < DateTime.now) || (f.user_id == user.id)
      end

      can %i[read manage], :all

      can :counted, Result
      # can :read, Material, groups_mask: user.groups_mask
      can %i[make_role edit_roles], User
      cannot :read, [Song, Album, Round, Forecast]
      cannot :download, Round, check_finish?: false
    end

    if (user.role? :admin) || (user.role? :moderator) || (user.role? :editor) || (user.role? :user)
      can :read, :all

      cannot %i[manage read], [Folder, Dataset, Event]

      can %i[manage read], Folder,  user:   { id: user.id }
      can %i[manage read], Dataset, folder: { user_id: user.id }
      can :show, User, id: user.id
      can %i[show edit update], Profile, user: { id: user.id }
      can %i[read manage list], Event, user: { id: user.id }
    end

    if user.role? :user
      can %i[update manage_holidays update_holidays], Member, user: { id: user.id }

      can %i[destroy edit update], Forecast do |f|
        (f.round.deadline > DateTime.now) && (f.user_id == user.id)
      end
      # cannot :read, Doc, category: { hidden: true }

      cannot :read, [Song, Album, Forecast, Round, Message, Type]
      cannot :index, User

      cannot :download, Round, check_finish?: false
    end

    ################# MODERATOR USER
    if user.role? :moderator
      can :manage, [Doc, Category]
    end

    if user.role? :editor
      can %i[manage read], Message
    end

    if user.role? :manager
      can :manage, [Member]
    end

    if user.has_group? :lab193
      can %i[manage read download], [Song, Album]
      can :get_results, Match
      can [:read, :list], Round
      can :like, Song
      can %i[favorites list], Album

      can %i[new create], Forecast, user: { id: user.id }
    end
  end
end
