module GroupsHelper
  def render_group_simple_format(group)
    simple_format(group.description)
  end
end
