class Project < ApplicationRecord
  audited only: [:status], associated_with: :user

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true

  include AASM

  aasm column: :status do
    state :pending, initial: true
    state :in_progress
    state :blocked
    state :in_review
    state :complete

    event :start do
      transitions from: :pending, to: :in_progress
    end

    event :review do
      transitions from: :in_progress, to: :in_review
    end

    event :complete do
      transitions from: :in_review, to: :complete
    end

    event :block do
      transitions from: :in_progress, to: :blocked
    end

    event :unblock do
      transitions from: :blocked, to: :in_progress
    end
  end

  def available_transitions
    aasm.events(permitted: true).map(&:name)
  end

  def valid_status_transitions
    if self.status == 'complete'
      ['complete']
    else
      aasm.events(permitted: true).map(&:transitions).flatten.map(&:to).uniq.map(&:to_s) + [self.status]
    end
  end
end
