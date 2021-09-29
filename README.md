# rubocop-amagi
Amagi rubocop rules


## How to use rubocop-amagi gem?
 To adapt amagi rubocop rules
  
  1. add rubocop and rubocop-amagi in your Gemfile:
  ~~~ruby
    gem "rubocop"
    gem "rubocop-amagi"
  ~~~
  
  2. install gems
   ~~~ruby
    bundle install
   ~~~
  
  3. add the below configuration in Rubocop config file(.rubocop.yml):
  ~~~ruby
    inherit_gem:
      rubocop-amagi: rubocop.yml
  ~~~
