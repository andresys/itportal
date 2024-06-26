module NestedHelper
  def nested_li(objects, options = {}, &block)
    objects = objects.order(:lft) if objects.is_a? Class

    return '' if objects.size == 0

    output = "<ol>"
    path = [nil]

    objects.each_with_index do |o, i|
      if o.parent_id != path.last
        # We are on a new level, did we descend or ascend?
        if path.include?(o.parent_id)
          # Remove the wrong trailing path elements
          while path.last != o.parent_id
            path.pop
            output << "</li></ol>"
          end
          output << "</li><li id='#{o.id}'>"
        else
          path << o.parent_id
          output << "<ol><li id='#{o.id}'>"
        end
      elsif i != 0
        output << "</li><li id='#{o.id}'>"
      else
        output << "<li id='#{o.id}'>"
      end
      output << capture(o, path.size - 1, &block)
      # output << "<ol></ol>" unless objects[i+1] && (objects[i+1].parent_id == o.id)
    end

    output << "</li></ol>" * path.length
    output.html_safe
  end

  def sorted_nested_li(objects, order, &block)
    nested_li sort_list(objects, order), &block
  end

  private

  def sort_list(objects, order)
    objects = objects.order(:lft) if objects.is_a? Class

    # Partition the results
    children_of = {}
    objects.each do |o|
      children_of[ o.parent_id ] ||= []
      children_of[ o.parent_id ] << o
    end

    # Sort each sub-list individually
    children_of.each_value do |children|
      children.sort_by! &order
    end

    # Re-join them into a single list
    results = []
    recombine_lists(results, children_of, nil)

    results
  end

  def recombine_lists(results, children_of, parent_id)
    if children_of[parent_id]
      children_of[parent_id].each do |o|
        results << o
        recombine_lists(results, children_of, o.id)
      end
    end
  end

end