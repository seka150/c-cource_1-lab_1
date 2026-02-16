cmake_minimum_required(VERSION 4.1)

# Символ решётки начинает комментарий, длящийся до конца строки

# Если поддержка модулей не нужна,
# следующие две строки можно удалить
set(CMAKE_CXX_MODULE_STD ON)
set(CMAKE_EXPERIMENTAL_CXX_IMPORT_STD d0edc3af-4c50-42ea-a356-e2862fe7a444)

project("my-awesome-project" CXX)

# Объявляем, что нужно будет собрать исполняемый файл с именем "awesome"
# На Windows расширение .exe будет добавлено автоматически
add_executable("awesome")

# При сборке "awesome" использовать стандарт C++23
target_compile_features("awesome" PUBLIC cxx_std_23)

# Собирать "awesome" из файла "main.cpp"
# Дополнительные файлы указываются через пробел и/или символ перевода строки
target_sources("awesome"
    PRIVATE
    "main.cpp"
#   PRIVATE FILE_SET "modules" TYPE CXX_MODULES FILES
#     "module.cppm"
)