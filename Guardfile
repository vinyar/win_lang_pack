# Guardfile for Windows 
# More info at https://github.com/guard/guard#readme

unit = Proc.new do |group,plugin|
  def load_plugin(plugin)
    guard plugin, :cli => "--color" do
      watch(%r{^spec/.+_spec\.rb$})
      watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
      watch('spec/spec_helper.rb')  { "spec" }
      watch(%r{^recipes/(.+)\.rb$}) { |m| "spec/unit/recipes/#{m[1]}_spec.rb" }
      watch(%r{^attributes/(.+)\.rb$})
      watch(%r{^files/(.+)})
      watch(%r{^templates/(.+)})
      watch(%r{^providers/(.+)\.rb}) { |m| "spec/unit/providers/#{m[1]}_spec.rb" }
      watch(%r{^resources/(.+)\.rb}) { |m| "spec/unit/resources/#{m[1]}_spec.rb" }
    end
  end

  def plugin_exist(plugin)
    # Method ::Guard.guards is depricated on version >= 2.0.0
    # Use ::Guard.plugins instead
    if ::Gem::Version.create(::Guard::VERSION) >= ::Gem::Version.create('2.0.0')
      if ::Guard.plugins(plugin).length == 0
        load_plugin(plugin)
      end
    else
      if ::Guard.guards(plugin).nil?
        load_plugin(plugin)
      end
    end
  end

  unless ::Guard.options[:group].empty?
    # At least one group should load the plugin
    if group.to_s == ::Guard.options[:group][0]
      plugin_exist(plugin)
    end
  else
    plugin_exist(plugin)
  end
end

# The Unit test will belongs to the `default` group since it is the same for both Unix & Windows 
unit.call(:default,:rspec)

# Windows specific guard plugin: `guard-rake-vagrant`
group :windows do
  unit.call(:windows,:rspec)
  guard :rake, :task => 'integration' do
    watch(%r{^test/.+_spec\.rb$})
    watch(%r{^recipes/(.+)\.rb$})
    watch(%r{^attributes/(.+)\.rb$})
    watch(%r{^files/(.+)})
    watch(%r{^templates/(.+)})
    watch(%r{^providers/(.+)\.rb})
    watch(%r{^resources/(.+)\.rb})
  end
end

# If your cookbook converge on Unix Boxes as well. 
# You should uncomment out the following Unix Group to 
# be able to test using Test-Kitchen Suite.

# group :unix do
#   unit.call(:unix,:rspec)
#   guard :kitchen do
#     watch(%r{test/.+})
#     watch(%r{^recipes/(.+)\.rb$})
#     watch(%r{^attributes/(.+)\.rb$})
#     watch(%r{^files/(.+)})
#     watch(%r{^templates/(.+)})
#     watch(%r{^providers/(.+)\.rb})
#     watch(%r{^resources/(.+)\.rb})
#   end
# end
