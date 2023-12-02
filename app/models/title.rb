class Title < ApplicationRecord
  include RailsSortable::Model
  set_sortable :sort
end
