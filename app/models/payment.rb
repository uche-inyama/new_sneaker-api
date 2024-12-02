class Payment < ApplicationRecord
  belongs_to :user, optional: true

  validates :stripe_payment_id, presence: true, uniqueness: true
  validates :amount, presence: true
  validates :status, inclusion: { in: %w[succeeded failed processing requires_action] }

  scope :created_within_last_48_hours, -> { where(created_at: 48.hours.ago..Time.current) }
  # scope :signed_in_user, -> { where()}
  
  def formatted_amount
    "$#{amount / 100.0}"
  end

end
