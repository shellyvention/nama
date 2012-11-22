# Seed database with initial data needed

# Clean the whole database
Timeslot.delete_all
Event.delete_all
GroupMember.delete_all
Group.delete_all
User.delete_all

# Default user to sign up the first time
User.create({
  last_name: "Administrator",
  first_name: "Nama",
  street: "Street 1",
  postal_code: 1111,
  city: "City",
  phone_landline: "",
  phone_mobile: "",
  date_of_birth: "01.01.1970",
  email: "nama@localhost.ch",
  password_digest: "$2a$10$9ABu/Wnt7lu8YR9tCKCPH.oWCf8dsOZ2CNFSz6RFo6x.56ssA1dsu",
  activation_token: nil,
  active: true,
  remember_token: nil},
  without_protection: true
)
