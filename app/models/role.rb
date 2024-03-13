class Role < ApplicationRecord
  has_and_belongs_to_many :users, :join_table => :users_roles
  
  belongs_to :resource,
             :polymorphic => true,
             :optional => true
  

  validates :name, presence: true
  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  scopify

  before_validation  { self.resource_type = nil unless resource_type.presence }

  def self.available_roles
    { user: %i[user admin superadmin], organization: %i[user admin] }
  end
end
