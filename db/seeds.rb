n = 15

while n <= 20
  name = Faker::Pokemon.name
  email = Faker::Internet.email
  password = Faker::Internet.password
  uid = SecureRandom.uuid

  User.create(
    id: n,
    name: name,
    email: email,
    password: password,
    uid: uid
  )
  n = n + 1
end



n = 15
while n <= 20
  Topic.create(
    title: "test",
    user_id: n
  )
  n = n + 1
end
