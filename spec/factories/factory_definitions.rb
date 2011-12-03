Factory.define :bucket do |f|
  f.name "MyString"
  f.account_id 1
end

Factory.define :discussion do |f|
  f.account_id 1
  f.user_id 1
  f.messages { [Factory.build(:message, :created_at => Time.now)] }
end

Factory.define :message do |f|
  f.discussion_id 1
  f.body "yo"
  f.user_id 1
end

Factory.define :user do |f|
  f.account_id 1
  f.email { Factory.next(:email) }
  f.password  "MyString"
  f.password_confirmation "MyString"
end

Factory.define :admin, :parent => :user, :class => "User::Admin" do |f|
end

Factory.define :ticket_holder, :parent => :user, :class => "User::TicketHolder" do |f|
end

Factory.sequence :email do |n|
  "somebody#{n}@whatevs.com"
end
