Gem::Specification.new do |s|
  s.name        = 'hash-to-conditions'
  s.version     = '0.3.0'
  s.date        = '2013-05-28'
  s.summary     = "Hash to conditions Array gem"
  s.description = "Transforms a given Hash into a conditions Array, for use with ActiveRecord find() or where() methods"
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
