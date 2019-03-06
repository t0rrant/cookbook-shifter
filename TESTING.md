This cookbook the following testing components:

- Integration tests: [Test Kitchen](https://github.com/opscode/test-kitchen)
- Chef Style lints: [Foodcritic](http://www.foodcritic.io/)
- Sane Ruby Style lints: [CookStyle](https://github.com/chef/cookstyle)

Prerequisites
-------------
To develop on this cookbook, you must have a sane Ruby 2.5+ environment.

You should have [ChefDK](https://downloads.chef.io/chefdk) **stable** release installed

You must also have either Vagrant and VirtualBox installed, or Docker:

- [Vagrant](https://vagrantup.com)
- [VirtualBox](https://virtualbox.org)
- [Docker](https://www.docker.com/)

Using vagrant, you should install the `vagrant-berkshelf` plugin:

    $ vagrant plugin install vagrant-berkshelf

Development
-----------
1. Clone the git repository from GitHub:

        $ git clone git@github.com:t0rrant/cookbook-shifter.git

2. Install the dependencies using bundler:

        $ bundle install

3. Create a branch for your changes:

        $ git checkout -b my_bug_fix

4. Make any changes
5. Write tests to support those changes. It is highly recommended you write both unit and integration tests.
6. Run the tests:
    - `bundle exec rspec`
    - `bundle exec foodcritic .`
    - `bundle exec cookstyle .`
    - `bundle exec kitchen test`

7. Assuming the tests pass, open a Pull Request on GitHub
