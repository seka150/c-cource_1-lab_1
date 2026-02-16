#!/usr/bin/env bash

set -euo pipefail  # выход при ошибках, неопределённых переменных и ошибках в пайпах

# Создаём build/, если нет
mkdir -p build
cd build || exit 1

# Пытаемся найти std.cppm автоматически
STD_CPPM=$(clang++ -print-file-name=std.cppm 2>/dev/null || true)

if [[ -z "$STD_CPPM" || ! -f "$STD_CPPM" ]]; then
    echo "Ошибка: std.cppm не найден"
    echo "Обычно лежит в /opt/homebrew/opt/llvm/share/libc++/v1/std.cppm"
    echo "Проверь: find /opt/homebrew -name std.cppm"
    exit 1
fi

echo "Найден std.cppm → $STD_CPPM"

# Компилируем std модуль, если .pcm отсутствует
if [[ ! -f std.pcm ]]; then
    echo "Компилируем std модуль..."
    clang++ -std=c++23 \
        -stdlib=libc++ \
        -fmodules \
        --precompile \
        -o std.pcm \
        "$STD_CPPM"
fi

# Компилируем main.cpp с использованием import std;
echo "Компилируем main.cpp..."
clang++ -std=c++23 \
    -stdlib=libc++ \
    -fmodules \
    -fprebuilt-module-path=. \
    -o main \
    ../main.cpp

if [[ $? -eq 0 ]]; then
    echo "Успех! Запускаю программу..."
    ./main
else
    echo "Ошибка компиляции"
    exit 1
fi