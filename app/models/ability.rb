class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)

    # everybody
    can :read, :all
    can [:archive, :stat], Member
    cannot [:manage, :read], [Message, Folder, Dataset, Substrate, Year, Machine, Task]
    can [:new, :create], Note
    cannot [:edit, :update], Profile
    # cannot :read, Doc, category: {hidden: true}
    can :rebuild, Result
    cannot :read, [Art, Work, Forecast, Song, Album, Round, Forecast, Type]
    cannot :mirrors, Substrate
    can :list, [Event]

    if user.role? :user
      can [:edit, :update], Profile, user_id: user.id
      can :read, :all
      can [:destroy, :edit, :update], Forecast do |f|
        (f.round.deadline > DateTime.now) && (f.user_id == user.id)
      end
      # cannot :read, Doc, category: {hidden: true}

      cannot :read, [Song, Album, Art, Work, Forecast, Round, Substrate, Year, Message, Type]
      can [:favorites], Subscribe
      cannot :download, Round, check_finish?: false
    end

    ################# MODERATOR USER
    if user.role? :moderator
      can :manage, [Doc, Category]
    end

    if user.role? :editor
      can [:manage, :read], Message
    end

    if user.role? :admin
      can [:read], Forecast do |f|
        (f.round.deadline < DateTime.now) || (f.user_id == user.id)
      end

      can [:read, :manage], :all
      cannot :manage, Work
      can [:import], Subscribe
      cannot [:read, :manage], [Dataset, Folder]

      can :counted, Result
#      can :read, Material, groups_mask: user.groups_mask
      cannot [:edit, :update], Art do |art|
        art.closed?
      end
      can [:make_role, :edit_roles], User
      cannot :read, [Art, Work, Song, Album, Round, Forecast]
      cannot :download, Round, check_finish?: false
      can :remote_show, Substrate
    end

    if (user.role? :admin) || (user.role? :moderator) || (user.role? :editor) || (user.role? :user)
      can [:manage, :read], Folder, user: {id: user.id}
      can [:manage, :read], Dataset, folder: {user_id: user.id}
    end

    if user.role? :drawing
      can [:index, :new, :create, :get_form], Substrate
      can [:destroy, :edit, :update, :show, :remote_show, :sort], Substrate, category: 'substrate'
    end

    if user.role? :mirrors
      can [:mirrors, :new, :create, :get_form], Substrate
      can [:destroy, :edit, :update, :show, :remote_show, :sort], Substrate, category: 'mirror'
    end

    if user.has_group? :art
      can :read, [Art, Work]
      can [:new, :create], Art
      can [:new, :create], Work, art: {closed?: false}
      can [:edit, :update, :destroy], Work, user: {id: user.id}, art: {closed?: false}
      can :manage, Source, work: {user_id: user.id}
    end

    if user.has_group? :lab193
      can [:manage, :read, :download], [Song, Album]
      can [:get_results], Match
      can [:read], [Art, Work, Round]
      can :like, Song
      can [:favorites, :list], Album

      can [:new, :create], Forecast, user: {id: user.id}
    end

    if user.has_group? :sellers
      can [:manage, :read], [Purchase, Year]
    end

    if user.has_group? :machine
      can :read, Machine
      can [:manage, :read], Task
    end
  end
end
