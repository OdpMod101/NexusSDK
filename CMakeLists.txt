cmake_minimum_required(VERSION 3.22.1)
project("NexusSDK")

# Konfiguracja kompilatora pod standard C++20
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Budujemy rdzeń naszego loadera jako plik .so dla Androida
add_library(nexus_core SHARED src/main.cpp)

# Łączymy z systemową biblioteką logowania Androida (NDK)
target_link_libraries(nexus_core log)
