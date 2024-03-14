class User < ApplicationRecord
  resourcify
  rolify

  serialize :preferences, type: Hash, coder: YAML

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  belongs_to :employee, optional: true

  attr_accessor :terms_of_service

  before_create :add_superadmin, if: Proc.new { User.count == 0 }
  # before_create { self.approved = true } if Proc.new { employee.email == email }

  validates :employee_id, presence: true
  validates :password, confirmation: true
  validates :terms_of_service, acceptance: true

  def name
    employee&.name
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def active_for_authentication?
    super && approved?
  end 
    
  def inactive_message
    approved? ? super : :not_approved
  end

  private

  def add_superadmin
    self.approved = true
    skip_confirmation_notification!
    self.confirmed_at = DateTime.now
    self.add_role(:superadmin)
  end
end
