# rake-hooks

Rake hooks let you add callbacks to rake:

[![Build Status](https://secure.travis-ci.org/guillermo/rake-hooks.png)](http://travis-ci.org/guillermo/rake-hooks)


## Usage

For example in your Rakefile

    require 'rake/hooks'
  
    task :say_hello do
      puts "Good Morning !"
    end
  
    after :say_hello do
      puts "GoodBye"
    end
  
    after :say_hello do
      puts "Now go to bed !"
    end
  
    before :say_hello do
      puts "Hi !"
    end
  
Now run with rake

    $ rake say_hello
    Hi !
    Good Morning !
    GoodBye
    Now go to bed !"
    
You can also pass more than one task and each task will be setup with the
callback

    before :say_hello, :say_goodbye do
      puts "Hi !"
    end
  
  
## Installation

With rubygems use:
    gem install rake-hooks

With other systems
  Add lib dir to load path.
  
## Dependencies

* Rake

## Author

Guillermo Álvarez <guillermo@cientifico.net>

## Web

http://github.com/guillermo/rake-hooks

## Date of writing 
  
4 Sep 2011
