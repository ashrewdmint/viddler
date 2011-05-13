require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "viddler"
    gem.summary = 'Ruby wrapper around Viddler.com API.'
    gem.email = 'ilya.sabanin@gmail.com'
    gem.homepage = "http://viddler.rubyforge.org"
    gem.authors = ["Ilya Sabanin"]

    gem.add_dependency("activesupport")
    gem.add_dependency("rest-client")
    gem.add_dependency("mime-types")

    gem.description = \
%{Ruby wrapper around Viddler.com[http://www.viddler.com] API.

== FEATURES:

Currently implemented API methods:

* viddler.videos.getRecordToken
* viddler.users.register
* viddler.users.auth
* viddler.users.getProfile
* viddler.users.setProfile
* viddler.users.setOptions
* viddler.videos.upload
* viddler.videos.getStatus
* viddler.videos.getDetails
* viddler.videos.getDetailsByUrl
* viddler.videos.setDetails
* viddler.videos.getByUser
* viddler.videos.getByTag
* viddler.videos.getFeatured
}

  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "test2 #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
