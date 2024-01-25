class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  belongs_to :employee, optional: true

  enum role: { user: 0, admin: 5, superadmin: 10 }

  validates :employee_id, presence: true
  # validates :email, email: {domain: 'adm.tver.ru', message: I18n.t('activerecord.errors.messages.must_contain_the_domain')}
  # validates :password, confirmation: true
  # validates :password_confirmation, presence: true

  def name
    employee&.name
  end
end
