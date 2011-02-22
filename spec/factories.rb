Factory.define :user do |user|
  user.first_name "Jim"
  user.last_name "McGaw"
  user.email "jim@somedomain.com"
  user.password "password"
  user.password_confirmation "password"
end
