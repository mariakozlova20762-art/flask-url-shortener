@echo off
chcp 65001 >nul
@echo off
echo ========================================
echo    ЗАПУСК ПРОЕКТА ЧЕРЕЗ DOCKER
echo ========================================
echo.

REM Проверка Docker
docker --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Docker не найден
    echo Установите Docker Desktop:
    echo https://www.docker.com/products/docker-desktop/
    pause
    exit
)

echo ✔ Docker найден
echo.

REM Остановка старых контейнеров
echo Останавливаю старые контейнеры...
docker compose down

REM Запуск
echo.
echo Запускаю контейнеры...
docker compose up --build

pause
