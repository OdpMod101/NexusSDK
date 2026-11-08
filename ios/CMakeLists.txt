cmake_minimum_required(VERSION 3.22)
project("NexusSDK_iOS")

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Wymuszamy kompilację wyłącznie pod procesory Apple iOS (64-bit)
set(CMAKE_OSX_ARCHITECTURES "arm64")
set(CMAKE_OSX_SYSROOT "iphoneos")

# Budujemy czysty plik silnika .dylib z naszego folderu src
add_library(nexus_core_ios SHARED src/main_ios.cpp)

# Podstawowe biblioteki systemowe Apple
target_link_libraries(nexus_core_ios "-framework Foundation")
