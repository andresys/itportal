class User < ApplicationRecord
  resourcify
  rolify

  serialize :preferences, type: Hash, coder: YAML
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  belongs_to :employee, optional: true

  attr_accessor :terms_of_service

  before_create :add_superadmin, if: Proc.new { User.count == 0 }

  validates :employee_id, presence: true
  validates :email, email: {domain: 'adm.tver.ru', message: I18n.t('activerecord.errors.messages.must_contain_the_domain')}, unless: :admin_for_user?
  validates :password, confirmation: true
  # validates :password_confirmation, presence: true
  validates :terms_of_service, acceptance: { message: I18n.t('activerecord.errors.messages.must_be_abided') }

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
  
  def admin_for_user?
    (current_user || self).has_any_role? :superadmin, :admin, { name: :admin, resource: User }
  end
end
