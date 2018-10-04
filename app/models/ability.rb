class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)

    # everybody
    can :read, :all
    can %i[archive stat holidays get_holidays], Member
    cannot %i[manage read], [Message, Folder, Dataset, Substrate, Year, Machine, Task]
    can %i[new create], Note
    cannot %i[edit update], Profile
    # cannot :read, Doc, category: { hidden: true }
    can :rebuild, Result
    cannot :read, [Art, Work, Forecast, Song, Album, Round, Forecast, Type, User]
    cannot :mirrors, Substrate
    can :list, [Event]

    if user.role? :user
      can %i[edit update], Profile, user_id: user.id
      can :read, :all
      can %i[destroy edit update], Forecast do |f|
        (f.round.deadline > DateTime.now) && (f.user_id == user.id)
      end
      # cannot :read, Doc, category: { hidden: true }

      cannot :read, [Song, Album, Art, Work, Forecast, Round, Substrate, Year, Message, Type, User]
      can :favorites, Subscribe
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

    if user.role? :admin
      can [:read], Forecast do |f|
        (f.round.deadline < DateTime.now) || (f.user_id == user.id)
      end

      can %i[read manage], :all

      cannot :manage, Work
      can :import, Subscribe
      cannot %i[read manage], [Dataset, Folder]

      can :counted, Result
      # can :read, Material, groups_mask: user.groups_mask
      cannot %i[edit update], Art do |art|
        art.closed?
      end
      can %i[make_role edit_roles], User
      cannot :read, [Art, Work, Song, Album, Round, Forecast]
      cannot :download, Round, check_finish?: false
      can :remote_show, Substrate
    end

    if (user.role? :admin) || (user.role? :moderator) || (user.role? :editor) || (user.role? :user)
      can %i[manage read], Folder,  user:   { id: user.id }
      can %i[manage read], Dataset, folder: { user_id: user.id }
    end

    if user.role? :drawing
      can %i[index new create get_form], Substrate
      can %i[destroy edit update show remote_show sort], Substrate, category: 'substrate'
    end

    if user.role? :mirrors
      can %i[mirrors new create get_form], Substrate
      can %i[destroy edit update show remote_show sort], Substrate, category: 'mirror'
    end

    if user.has_group? :art
      can :read, [Art, Work]
      can %i[new create], Art
      can %i[new create], Work, art: { closed?: false }
      can %i[edit update destroy], Work, user: { id: user.id }, art: { closed?: false }
      can :manage, Source, work: { user_id: user.id }
    end

    if user.has_group? :lab193
      can %i[manage read download], [Song, Album]
      can :get_results, Match
      can :read, [Art, Work, Round]
      can :like, Song
      can %i[favorites list], Album

      can %i[new create], Forecast, user: { id: user.id }
    end

    if user.has_group? :sellers
      can %i[manage read], [Purchase, Year]
    end

    if user.has_group? :machine
      can :read, Machine
      can %i[manage read], Task
    end
  end
end
