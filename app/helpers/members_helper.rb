module MembersHelper
  def show_birth(object)
    l object.birth, format: :short
  end
end
