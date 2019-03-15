module AncestryHelper
  # arranged as tree expects 3 arguments. The hash from has_ancestry.arrange() method,
  # options, and a render block

  def arranged_tree_as_list(hash, options = {}, &block)
      options = {
            :list_type            => :ul,
            :list_style           => '',
            :ul_class             => [],
            :ul_class_top         => ['list-group list-group-flush nav-reddevil'],
            :ul_class_children    => ['list-group list-group-flush'],
            :li_class             => ['list-group-item'],
            :li_class_top         => [],
            :li_class_children    => %w(nav-children slide-block list-group-item),
            :sort_by              => []
        }.merge(options)
        # setup any custom list styles you want to use here. An example is excluded
        # to render bootstrap style list groups. This is used to keep from recoding the same
        # options on different lists
        options[:list_style] = ''
        output = ''
      # sort the hash key based on sort_by options array
    unless options[:sort_by].empty?
      hash = Hash[hash.sort_by{|k, v| options[:sort_by].collect {|sort| k.send(sort)} } ]
    end

    current_depth = 0
    # and here... we... go...
    hash.each do |object, children|
      li_classes = options[:li_class]

      if object.depth == 0
        li_classes += options[:li_class_top]
      else
        li_classes += options[:li_class_children]
      end

      if children.size > 0
        output << content_tag(:li, capture(object, &block) + arranged_tree_as_list(children, options, &block).html_safe, class: li_classes)
      else
        output << content_tag(:li, capture(object, &block), class: li_classes).html_safe
        current_depth = object.depth
      end
    end

    unless output.blank?
      ul_classes = options[:ul_class]
      if current_depth == 0
        ul_classes += options[:ul_class_top]
      else
        ul_classes += options[:ul_class_children]
      end

      output = content_tag(options[:list_type], output.html_safe, class: ul_classes)
    end

    return output.html_safe
  end
end