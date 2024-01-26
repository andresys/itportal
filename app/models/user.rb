class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  belongs_to :employee, optional: true

  enum role: { user: 0, admin: 5, superadmin: 10 }
  attr_accessor :terms_of_service

  validates :employee_id, presence: true
  validates :email, email: {domain: 'adm.tver.ru', message: I18n.t('activerecord.errors.messages.must_contain_the_domain')}
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
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
end
