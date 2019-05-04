# VpsCli

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/vps_cli`. To experiment with that code, run `bin/console` for an interactive prompt.

This gem is currently unfinished and purely for my own personal use.
This project of pulling and pushing dotfiles as well as performing installations
etc has taken many iterations and this is its 3rd iteration

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vps_cli', git: 'https://github.com/ParamagicDev/vps_cli'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vps_cli

## Usage

This is a personal gem intended to help keep dotfiles the and packages
the same across installations

General usage is as follows:

```bash
vps-cli init
```

This will create a .vps_cli file in your home folder.

You should check out the contents of this file because this will provide
the defaults used for configuration

This opens up further commands like:

```bash
vps-cli pull 
# pulls in all the dotfiles to your specified dotfiles and misc_files

vps-cli copy
# copies all the dotfiles and misc files to your specified local_dir

vps-cli git_pull
# pulls in changes to your config_files directory

vps-cli git_push
# pushes changes in your config_files directory

vps-cli
# will list all available commands
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/vps_cli.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
