User.create!(name: "わい管理者や！",
             email: "admin@email.com",
             password: "Password",
             password_confirmation: "Password",
             admin: true)

Operation.create!(seat: 5,
                  all_seat: 30)
                  
60.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "Password"
  User.create!(name: name,
               email: email,
               password: "Password",
               password_confirmation: "Password")
end

users = User.order(:created_at).take(3)
5.times do |n|
 meeting_on = Date.current + 1
 started_at = Time.current.change(hour: 10, min: 0, sec: 0)
 finished_at = Time.current.change(hour: 18, min: 0, sec: 0)
 users.each { |user| user.reservations.create!(meeting_on: meeting_on, started_at: started_at, finished_at: finished_at) }
end