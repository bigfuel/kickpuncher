# require 'mongoid/carrierwave_fix'

class Project
  include Mongoid::Document
  include Mongoid::Timestamps
  # include Mongoid::CarrierwaveFix

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :token_authenticatable, :trackable, :lockable

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Encryptable
  # field :password_salt, type: String

  ## Lockable
  field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  field :locked_at,       type: Time

  ## Token authenticatable
  field :authentication_token, type: String


  field :state, type: String, default: 'inactive'
  field :name, type: String
  field :description, type: String
  field :facebook_app_id, type: String
  field :facebook_app_secret, type: String
  field :google_analytics_tracking_code, type: String
  field :production_url, type: String

  index :name, unique: true

  attr_accessible :name, :description, :facebook_app_id, :facebook_app_secret, :google_analytics_tracking_code, :production_url, :authentication_token

  has_many :events, dependent: :destroy
  has_many :signups, dependent: :destroy
  has_many :polls, dependent: :destroy
  has_many :videos, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :submissions, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :feeds, dependent: :destroy
  has_many :facebook_albums, dependent: :destroy
  has_many :facebook_events, dependent: :destroy

  before_save :ensure_authentication_token

  scope :active, where(state: 'active')
  scope :inactive, where(state: 'inactive')

  paginates_per 50

  validates :name, presence: true, uniqueness: true

  state_machine initial: :inactive do
    event :activate do
      transition inactive: :active
    end

    event :deactivate do
      transition active: :inactive
    end
  end

  def touch
    self.updated_at = Time.current
    self.save
  end

  def to_param
    self.name
  end

  def verify_auth_token(auth_token)
    auth_token == self.authentication_token
  end

  def self.find_by_name(name)
    where(name: name).limit(1).first
  end

  def self.find_by_name_and_auth_token(name, auth_token)
    where(name: name, authentication_token: auth_token).limit(1).first
  end
end