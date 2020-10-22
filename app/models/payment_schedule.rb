# == Schema Information
#
# Table name: payment_schedules
#
#  id                :integer          not null, primary key
#  name              :string
#  description       :string
#  amount_in_pennies :integer
#  recurrence_start  :datetime
#  recurrence_date   :integer
#  recurrence_wday   :integer
#  recurrence_type   :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class PaymentSchedule < ApplicationRecord

  enum recurrence_wday: {
      sunday: 0,
      monday: 1,
      tuesday: 2,
      wednesday: 3,
      thursday: 4,
      friday: 5,
      saturday: 6
  }

  enum recurrence_type: { daily: 0, weekly: 1, biweekly: 2, monthly: 3, bimonthly: 4, quarterly: 5, semiyearly: 6, biyearly: 7 }
end
