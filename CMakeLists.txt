cmake_minimum_required(VERSION 3.22.1)
project("NexusSDK")

# Ustawiamy standard C++20 dla operacji na plikach (std::filesystem)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Budujemy bibliotekę z pliku src/main.cpp
add_library(nexus_core SHARED src/main.cpp)

# Poprawne linkowanie podstawowych bibliotek Androida (logowanie i system)
target_link_libraries(nexus_core log)
