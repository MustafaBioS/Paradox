class AddReferralsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :referral_code, :string
    add_column :users, :referrals_count, :integer, default: 0, null: false
    add_reference :users, :referred_by, foreign_key: { to_table: :users }, index: true
    add_index :users, :referral_code, unique: true
  end
end

