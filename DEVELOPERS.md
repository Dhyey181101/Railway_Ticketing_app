# Steps
1. Clone Amazone
2. Change ruby version and depedencies version
3. Modify to add admin column to user and add seed admin user
4. run `bundle install`
5. run `rails db:migrate`
6. run `rails db:seed`
7. run server `rails s`
8. Try loggin in with admin user (admin:admin@ncsu.edu:admin)(username:email:password)
9. Scaffold commands to create associations
   1. rails generate scaffold Train train_number:integer{5} departure_station:string termination_station:string departure_date:date departure_time:time arrival_date:date arrival_time:time ticket_price:decimal max_seats:integer available_seats:integer
   2. rails generate scaffold Ticket user:references train:references confirmation_number:integer{10}
   3. rails generate scaffold Review user:references train:references rating:integer{1} feedback:text
10. run `rails db:migrate`