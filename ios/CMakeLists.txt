cmake_minimum_required(VERSION 3.22)
project("NexusSDK_iOS_App")

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Ustawienia architektury procesorów Apple
set(CMAKE_OSX_ARCHITECTURES "arm64")
set(CMAKE_OSX_SYSROOT "iphoneos")

# Tworzymy aplikację jako Bundle (osobny program na iOS)
add_executable(NexusLauncher MACOSX_BUNDLE 
    src/main_ios.mm
    Info.plist
)

# Podpinamy nasz plik Info.plist do aplikacji
set_target_properties(NexusLauncher PROPERTIES
    MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_SOURCE_DIR}/Info.plist
)

# Linkowanie podstawowych frameworków graficznych iOS (UIKit i Foundation)
target_link_libraries(NexusLauncher "-framework Foundation" "-framework UIKit")
