# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app 
#ApplicationController inherits from Sinatra::Base
- [x] Use ActiveRecord for storing information in a database 
#ActiveRecord handles all database usage
- [x] Include more than one model class (e.g. User, Post, Category) 
#User and BoardGame models
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts) 
#User has_many Boardgames
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User) 
#BoardGame belongs_to User
- [x] Include user accounts with unique login attribute (username or email) 
#Username and Email uniqueness set to true
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
#Boardgames has full CRUD funtionality
- [x] Ensure that users can't modify content created by other users
#logic checks for user_id == current_user.id
- [x] Include user input validations
#certain accepted inputs cannot be blank thanks to presence set to true
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
#User receives error messages when taking an unallowed action
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
#See readme in repo

Confirm
- [x] You have a large number of small Git commits
#Committed often
- [x] Your commit messages are meaningful
#Commit messages are relevant
- [x] You made the changes in a commit that relate to the commit message
#Most often yes
- [ ] You don't include changes in a commit that aren't related to the commit message
#Definitely occassionally committed more than the commit message would indicate.