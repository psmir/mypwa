class AddAddresseeIdToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :addressee_id, :bigint
  end
end
