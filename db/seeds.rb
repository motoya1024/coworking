User.create!(name: "わい管理者や！",
             email: "admin@email.com",
             password: "password",
             password_confirmation: "password",
             admin: true)
             
User.create!(name: "わいサンプルさん",
             email: "sample@email.com",
             password: "password",
             password_confirmation: "password")

Operation.create!(seat: 5,
                  all_seat: 30)