class ChangeDataOwnerIdToGroups < ActiveRecord::Migration[5.2]
  def change
    change_column :groups, :owner_id, :integer
  end
end
