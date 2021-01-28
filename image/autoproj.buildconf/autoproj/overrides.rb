#                    Under MIT License
#author Gabriel Arjones

# Write in this file customization code that will get executed after all the
# soures have beenloaded.


Autoproj.manifest.each_autobuild_package do |pkg|
    pkg.define "CMAKE_EXPORT_COMPILE_COMMANDS", "ON" if pkg.kind_of?(Autobuild::CMake)
end
