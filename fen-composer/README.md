# fen-composer

TODO: Enter the cookbook description here.

This cookbook should run only after cookbook fen-drush.

default['user']="vagrant" # This specifies the user through which composer install will run.

It has 2 recipes :

default.rb : which is a wrapper of composer cookbook.

install.rb : which runs composer install command.
