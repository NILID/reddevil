class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)


    #everybody
    cannot [:manage, :read], [Message, Folder, Dataset]
    can [:new, :create], Note
    cannot [:edit, :update], Profile
    cannot :read, Doc, category: {hidden: true}
    can :read, :all
    can :rebuild, Result
    cannot :read, [Art, Work, Forecast, Song, Album, Round, Forecast]
    can :list, [Event]

    if user.role? :user
      can [:edit, :update], Profile, user: {id: user.id}
      can :read, :all
      can [:destroy, :edit, :update], Forecast do |f|
        (f.round.deadline > DateTime.now) && (f.tempuser.user_id == user.id)
      end

      cannot :read, Doc, category: {hidden: true}

      cannot [:manage, :read], Message
      cannot :read, [Song, Album, Art, Work, Forecast, Round]
      can [:favorites], Subscribe
    end

    ################# MODERATOR USER
    if user.role? :moderator
      can :manage, [Doc, Category]
      can [:new, :create], [Art]
      can [:new, :create], Work, art: {closed?: false}
      can [:edit, :update, :destroy], Work, user: {id: user.id}, art: {closed?: false}
      can :manage, Source, work: {user_id: user.id}
    end

    if user.role? :editor
      can [:manage, :read], Message
    end

    if user.role? :admin

      can [:read], Forecast do |f|
        (f.round.deadline < DateTime.now) || (f.tempuser.user_id == user.id)
      end

      can [:read, :manage], :all
      can [:import], Subscribe
      cannot [:read, :manage], [Dataset, Folder]

      can :counted, Result
#      can :read, Material, groups_mask: user.groups_mask
      cannot [:edit, :update], Art do |art|
        art.closed?
      end
      can :make_role, User
      cannot :read, [Art, Work, Song, Album, Round, Forecast]
    end

    if (user.role? :admin) || (user.role? :moderator) || (user.role? :editor) || (user.role? :user)
      can [:manage, :read], Folder, user: {id: user.id}
      can [:manage, :read], Dataset, folder: {user_id: user.id}
    end

    if user.has_group? :lab193
      can [:manage, :read], [Song, Album, Art, Work]
      can [:read], [Art, Work, Round]
      can :like, Song
      can [:favorites, :list], Album

      can [:new, :create], Forecast, tempuser: {user_id: user.id}
    end

    if user.has_group? :sellers
      can [:manage, :read], [Purchase]
    end
  end
end
