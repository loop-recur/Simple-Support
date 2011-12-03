# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
# User::Admin id: 1, name: "Brian", email: "brian@lateporter.com", encrypted_password: "$2a$10$IYanmLKTaJAE9CCJyB45uOfx0uyk1iSM18K9j4zMkmUI...", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 6, current_sign_in_at: "2011-11-30 23:30:23", last_sign_in_at: "2011-11-29 19:41:28", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", avatar_file_name: "hat_small.jpg", avatar_content_type: "image/jpeg", avatar_file_size: 37830, avatar_updated_at: "2011-11-29 17:49:06", role: nil, account_id: 1, type: "User::Admin
account = Account.create(:validate => false)
user = User::Admin.create(:name => "Guy", :email => "brian@looprecur.com", :password => "Secret123",:password_confirmation => "Secret123", :account_id => account.id)
account.update_attribute(:user_id, user.id)
