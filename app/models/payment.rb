class Payment < ApplicationRecord
  belongs_to :user, optional: true

  validates :stripe_payment_id, presence: true, uniqueness: true
  validates :amount, presence: true
  validates :status, inclusion: { in: %w[succeed failed processing requires_action] }

  def formatted_amount
    "$#{amount / 100.0}"
  end
end
