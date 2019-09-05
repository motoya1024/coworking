User.create!(name: "わい管理者や！",
             email: "admin@email.com",
             password: "password",
             password_confirmation: "password",
             admin: true)

Operation.create!(seat: 5,
                  all_seat: 30)
                  
60.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end