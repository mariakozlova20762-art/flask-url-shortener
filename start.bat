@echo off
chcp 65001 >nul
@echo off
echo ========================================
echo    ЗАПУСК СОКРАЩАТЕЛЯ ССЫЛОК
echo ========================================
echo.
echo Установка и запуск могут занять 1-2 минуты...
echo.

REM Переходим в папку со скриптом
cd /d "%~dp0"

REM Проверяем Python
python --version >nul 2>&1
if errorlevel 1 (
    echo ОШИБКА: Python не найден!
    echo.
    echo Установите Python с сайта:
    echo https://www.python.org/downloads/
    echo.
    echo При установке ОБЯЗАТЕЛЬНО отметьте:
    echo [✓] Add Python to PATH
    echo.
    pause
    exit
)

REM Создаем виртуальное окружение
if not exist "venv" (
    echo Создаю виртуальное окружение...
    python -m venv venv
)

REM Активируем окружение
echo Активирую виртуальное окружение...
call venv\Scripts\activate.bat

REM Устанавливаем зависимости
echo Устанавливаю зависимости...
pip install --upgrade pip
pip install flask flask-sqlalchemy python-dotenv shortuuid user-agents validators

REM Копируем .env если его нет
if not exist ".env" (
    if exist ".env.example" (
        echo Создаю файл настроек...
        copy .env.example .env
    )
)

REM Запускаем приложение
echo.
echo ========================================
echo    ВСЁ ГОТОВО!
echo ========================================
echo.
echo Сервер запускается...
echo.
echo ОТКРОЙТЕ БРАУЗЕР И ПЕРЕЙДИТЕ ПО АДРЕСУ:
echo      http://localhost:5000
echo.
echo ИЛИ нажмите Ctrl и кликните ссылку:
echo      http://127.0.0.1:5000
echo.
echo Чтобы остановить сервер, нажмите Ctrl+C
echo ========================================
echo.

REM Запускаем Flask приложение
python src\app.py

pause