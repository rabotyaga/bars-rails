class User < ActiveRecord::Base
  default_scope { order(:created_at) }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :logs

  def active_for_authentication?
    return super && active?
  end

  def can_any
    can_add || can_edit || can_delete
  end
end
