class ChangeColumnEmailInUsuarios < ActiveRecord::Migration[5.0]
  def change
  	remove_index :usuarios, :email
  end
end
