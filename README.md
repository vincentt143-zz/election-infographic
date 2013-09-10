#fanfour (temporary name)
## Developer setup instructions
### Installing packages and rvm (Ruby Version Manager)
> sudo apt-get install git
>
> $ \curl -L https://get.rvm.io | bash

Eventually we will need to install postgres as well but I haven't figured that part out yet.
### Clone the repo
> git clone https://github.com/vincentt143/fanfour
>
> cd fanfour

### Set up rails environment
> rvm install ruby-2.0.0-p195

To check if rvm is currently using the right version, type one of the two

> rvm use
>
> cd .

Your terminal should display what version rvm is currently using. If it says ruby-2.0.0-p195@test-app, you're good to go

> gem install bundler
>
> bundle install

Eventually we'll put some rake tasks to migrate and seed the database.
