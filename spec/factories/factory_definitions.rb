Factory.define :discussion do |f|
  f.messages  { [Factory.build(:message)] }
end

Factory.define :message do |f|
end

Factory.define :user do |f|
  f.email { Factory.next(:email) }
  f.password  "MyString"
  f.password_confirmation "MyString"
end

Factory.sequence :email do |n|
  "somebody#{n}@whatevs.com"
end
