Autotest.add_discovery { "rspec2" }

Autotest.add_hook :initialize do |at|
  at.add_mapping(%r%^spec/.*\.rb$%) do |filename, _|
    filename
  end
end
