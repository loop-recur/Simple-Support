Factory.define :discussion do |f|
  f.account_id 1
  f.user_id 1
  f.messages  { [Factory.build(:message)] }
end

Factory.define :message do |f|
  f.discussion_id 1
  f.user_id 1
end

Factory.define :user do |f|
  f.account_id 1
  f.email { Factory.next(:email) }
  f.password  "MyString"
  f.password_confirmation "MyString"
end

Factory.sequence :email do |n|
  "somebody#{n}@whatevs.com"
end
