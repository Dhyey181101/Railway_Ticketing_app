# Rails on Rails Ticket System
Rails on Rails Ticket System - CSC/ECE 517 (OO Design and Development) Program 2: Ruby on Rails

## Link to the deployed application
http://152.7.177.29:8080/

## Admin credentials
* email : admin@ncsu.edu
* password : admin

## Setting up

* Clone this repository
```
git clone https://github.ncsu.edu/dshah22/CSC_ECE_517_Fall2023_Program_2
```
* Go to the directory
```
CSC_ECE_517_Fall2023_Program_2
```
* Install required gems
```
bundle install
```
* Run database migration on your system
```
rails db:migrate
```
* Run seed for setting up the required data
```
rails db:seed
```
* Finally, run the rails server
```
rails server
```

## User Functionalities

* User can perform follwing actions on the Home page:
  * View available trains
  * View their ticket history
  * Create new review
  * View their reviews
  * View account details
  
 * User can book a ticket through "Available Trains" --> "Book Ticket" --> "Confirm"  
 * User can edit account details through "Account Details" --> "Edit" --> "Update User"
 
## Admin Functionalities

* Admin can perform follwing actions on the Home page:
  * Create new train
  * View available trains
  * Create new user
  * View all users
  * View all reviews
  * View account details
  
 * Admin may view, edit, delete or book a ticket through "Available Trains"
 * Admin may view, edit, delete a user through "View All Users"
 * Admin may view, edit, delete a user through "View All Reviews"


### Contributors

---

<table>
  <tr>
    <td align="center"><a href="https://github.ncsu.edu/dshah22"><img src="https://avatars.github.ncsu.edu/u/30646" width="75px;" alt=""/><br /><sub><b>Dhyey Samirbhai Shah</b></sub></a></td>
    <td align="center"><a href="https://github.ncsu.edu/smule"><img src="https://avatars.github.ncsu.edu/u/30685" width="75px;" alt=""/><br /><sub><b>Siddhi Mule</b></sub></a><br /></td>
    <td align="center"><a href="https://github.ncsu.edu/avarma4"><img src="https://avatars.github.ncsu.edu/u/30743" width="75px;" alt=""/><br /><sub><b>Aditi Gulabchand Varma</b></sub></a><br /></td>
  </tr>
</table>
