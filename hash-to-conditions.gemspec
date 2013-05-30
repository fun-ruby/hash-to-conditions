Gem::Specification.new do |s|
  s.name        = 'hash-to-conditions'
  s.version     = '0.3.2'
  s.date        = '2013-05-29'
  s.summary     = "Hash to conditions Array gem"
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
  s.homepage    = 'http://rubygems.org/gems/hash-to-conditions'
end
