class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActsAsList::Mongoid

  field :state, type: String, default: 'pending'
  field :name, type: String
  field :type, type: String
  field :start_date, type: DateTime
  field :end_date, type: DateTime
  field :url, type: String
  field :details, type: String

  attr_accessible :name, :type, :start_date, :end_date, :url, :details, :location_attributes

  embeds_one :location, as: :locationable

  accepts_nested_attributes_for :location

  belongs_to :project

  paginates_per 20

  validates :name, :start_date, presence: true

  scope :pending, where(state: "pending")
  scope :approved, where(state: "approved")
  scope :denied, where(state: "denied")
  scope :future, where(:start_date.gt => Time.current)

  state_machine initial: :pending do
    event :approve do
      transition [:pending, :denied] => :approved
    end

    event :deny do
      transition [:pending, :approved] => :denied
    end
  end

  def as_json(options={})
    results = super({ method: location }.merge(options))
    results['start_date'] = start_date.strftime("%a %b %d, %Y %I:%M %p")
    results['end_date'] = end_date.strftime("%a %b %d, %Y %I:%M %p") if end_date
    results
  end
end