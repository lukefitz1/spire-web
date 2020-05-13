class UpdateUsersForTokenAuth < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :provider, :string, null: false, default: 'email'
    add_column :users, :uid, :string, null: false, default: ''
    add_column :users, :tokens, :text

    # updates the user table immediately with the above defaults
    User.reset_column_information

    # finds all existing users and updates them.
    # if you change the default values above you'll also have to change them here below:
    User.find_each do |user|
      user.uid = user.email
      user.provider = 'email'
      user.save!
    end

    # to speed up lookups to these columns:
    add_index :users, [:uid, :provider], unique: true
  end

  def down
    remove_columns :users, :provider, :uid, :tokens
  end
end
