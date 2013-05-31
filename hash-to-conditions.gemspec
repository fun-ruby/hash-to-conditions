Gem::Specification.new do |s|
  s.name        = 'hash-to-conditions'
  s.version     = '0.3.3'
  s.date        = '2013-05-31'
  s.summary     = "Converts a Hash to ActiveRecord Array conditions"
  s.description = "The HashToConditions gem provides an easy way to build ActiveRecord Array conditions directly from a Hash."
  s.authors     = ["Long On"]
  s.email       = 'on.long.on@gmail.com'
  s.files       = ["lib/hash_to_conditions.rb",
                   "lib/helpers/string_helper.rb",
                   "lib/helpers/array_helper.rb",
                   "lib/helpers/hash_helper.rb",
                   "lib/ext/array.rb",
                   "lib/ext/string.rb",
                   "lib/ext/hash.rb"
                  ]
  s.homepage    = 'https://rubygems.org/gems/hash-to-conditions'
  s.has_rdoc    = true
  s.license     = 'MIT'
end
