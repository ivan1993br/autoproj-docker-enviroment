#                    Under MIT License
#author Gabriel Arjones

# Write in this file customization code that will get executed before
# autoproj is loaded.

# Set the path to 'make'
# Autobuild.commands['make'] = '/path/to/ccmake'

# Set the parallel build level (defaults to the number of CPUs)
# Autobuild.parallel_build_level = 10

# Uncomment to initialize the environment variables to default values. This is
# useful to ensure that the build is completely self-contained, but leads to
# miss external dependencies installed in non-standard locations.
#
# set_initial_env
#
# Additionally, you can set up your own custom environment with calls to env_add
# and env_set:
#
# env_add 'PATH', "/path/to/my/tool"
# env_set 'CMAKE_PREFIX_PATH', "/opt/boost;/opt/xerces"
# env_set 'CMAKE_INSTALL_PATH', "/opt/orocos"
#
# NOTE: Variables set like this are exported in the generated 'env.sh' script.
#

require 'autobuild/import/git-lfs'

FileUtils.mkdir_p File.join(Autoproj.prefix, 'lib', 'python2.7', 'dist-packages')
FileUtils.mkdir_p File.join(Autoproj.prefix, 'lib', 'python2.7', 'site-packages')

Autoproj.env_add_path 'PYTHONPATH', File.join(Autoproj.prefix, 'lib', 'python2.7', 'dist-packages')
Autoproj.env_add_path 'PYTHONPATH', File.join(Autoproj.prefix, 'lib', 'python2.7', 'site-packages')
Autoproj.env_add_path 'LD_LIBRARY_PATH', File.join(Autoproj.prefix, 'lib')
Autoproj.config.set('build', File.join(Autoproj.root_dir, 'build')) unless Autoproj.config.get('build', nil)
Autoproj.config.set('source', 'src') unless Autoproj.config.source_dir

if Autoproj.config.user_shells.empty?
   Autoproj.config.user_shells = ['bash']
end

(['sh'] + Autoproj.config.user_shells).each do |shell|
    shell_helper = "setup.#{shell}"
    FileUtils.touch File.join(Autoproj.prefix, shell_helper)
    Autoproj.env_source_after(File.join(Autoproj.prefix, shell_helper), shell: shell)
end


#

require 'autoproj/gitorious'
Autoproj.gitorious_server_configuration('GITORIOUS', 'gitorious.org')
Autoproj.gitorious_server_configuration('GITHUB', 'github.com', :http_url => 'https://github.com')

