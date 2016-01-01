source "https://rubygems.org"

ruby "2.2.3"

# Web framework
gem "puma"
gem "rodakase", git: "https://github.com/solnic/rodakase", branch: "master"
gem "shotgun"

# Database persistence
gem "pg"
gem "rom", git: "https://github.com/rom-rb/rom", branch: "master"
gem "rom-mapper", git: "https://github.com/rom-rb/rom-mapper", branch: "master"
gem "rom-repository", git: "https://github.com/rom-rb/rom-repository", branch: "master"
gem "rom-sql", git: "https://github.com/rom-rb/rom-sql", branch: "master"
gem "rom-support", git: "https://github.com/rom-rb/rom-support", branch: "master"

# Application dependencies
gem "bcrypt-ruby"
gem "call_sheet", git: "https://github.com/icelab/call_sheet", branch: "master"
gem "dry-data"
gem "dry-equalizer"
gem "dry-validation"
gem "dry-component", git: "https://github.com/timriley/dry-component", branch: "import-containers-for-import-module"
gem "either_result_matcher"
gem "i18n"
gem "slim"
gem "transproc", git: "https://github.com/solnic/transproc", branch: "master"

group :development, :test do
  gem "guard-rspec", require: false
  gem "pry-byebug"
end

group :test do
  gem "capybara", require: false
  gem "capybara-screenshot", require: false
  gem "database_cleaner"
  gem "inflecto"
  gem "rspec"
  gem "site_prism"
end
