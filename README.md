cp Procfile.dev Profile

foreman start

rails c

add User

user = User.create!(email:"example@gmail.com",name:"example",password:"password",password_confirmation:"password")

initialize balance
user.wallet.balance = 1000
user.wallet.save!

user2 = User.create!(email:"example2@gmail.com",name:"example2",password:"password",password_confirmation:"password")

user.wallet.withdraw(user2.wallet, 100)