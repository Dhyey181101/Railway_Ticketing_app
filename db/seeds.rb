User.destroy_all

user= User.create([
    {
        id: 1,
        name: "Admin",
        username: "admin",
        email_address: "admin@ncsu.edu",
        # Password is admin
        password_digest: "$2a$04$LLzqAuloPcA7RoBgoRxlouoUr3.mG0mxCZ6uPGszldIYlCd7QCVx2",
        phone_number: 9876543210,
        credit_card: "1234-1234-1234-1234",
        address: "Raleigh, NC",
        admin: true
    }
])

p "Created #{User.count} users"
