class AddColumnUidToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :usuarios, :provider, :string
    add_column :usuarios, :uid, :string
  end
end
