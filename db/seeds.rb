# Seed database with initial data needed

# Clean all tables
Rating.delete_all
Timeslot.delete_all
Event.delete_all
GroupMember.delete_all
Group.delete_all
User.delete_all

# Default admin user to sign in the first time
User.new({
  last_name: "Administrator",
  email: "nama",
  password_digest: "$2a$10$9ABu/Wnt7lu8YR9tCKCPH.oWCf8dsOZ2CNFSz6RFo6x.56ssA1dsu",
  activation_token: nil,
  active: true,
  remember_token: nil,
  role: 1},
  without_protection: true
).save(validate: false)
