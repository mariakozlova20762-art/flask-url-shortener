@echo off
chcp 65001 >nul
@echo off
echo ========================================
echo   СОЗДАНИЕ ПРОЕКТА СОКРАЩАТЕЛЯ ССЫЛОК
echo ========================================
echo.

REM Проверяем Python
python --version >nul 2>&1
if errorlevel 1 (
    echo ОШИБКА: Python не установлен!
    echo Скачайте с https://www.python.org/downloads/
    echo При установке ОБЯЗАТЕЛЬНО отметьте "Add Python to PATH"
    pause
    exit
)

echo Шаг 1: Создаю папку проекта...
set PROJECT_DIR=%USERPROFILE%\Desktop\url-shortener
if exist "%PROJECT_DIR%" (
    echo Папка уже существует: %PROJECT_DIR%
) else (
    mkdir "%PROJECT_DIR%"
    echo Создана папка: %PROJECT_DIR%
)

echo Шаг 2: Создаю структуру папок...
mkdir "%PROJECT_DIR%\src" 2>nul
mkdir "%PROJECT_DIR%\src\templates" 2>nul
mkdir "%PROJECT_DIR%\src\static" 2>nul

echo Шаг 3: Создаю все файлы проекта...

REM Создаем requirements.txt
echo Flask==3.0.0 > "%PROJECT_DIR%\requirements.txt"
echo Flask-SQLAlchemy==3.1.1 >> "%PROJECT_DIR%\requirements.txt"
echo python-dotenv==1.0.0 >> "%PROJECT_DIR%\requirements.txt"
echo shortuuid==1.0.11 >> "%PROJECT_DIR%\requirements.txt"
echo user-agents==2.2.0 >> "%PROJECT_DIR%\requirements.txt"
echo validators==0.22.0 >> "%PROJECT_DIR%\requirements.txt"

REM Создаем .env.example
echo SECRET_KEY=your-secret-key-change-this-in-production > "%PROJECT_DIR%\.env.example"
echo BASE_URL=http://localhost:5000 >> "%PROJECT_DIR%\.env.example"
echo DATABASE_URL=sqlite:///./short_links.db >> "%PROJECT_DIR%\.env.example"
echo MAX_URL_LENGTH=2000 >> "%PROJECT_DIR%\.env.example"
echo SHORT_CODE_LENGTH=8 >> "%PROJECT_DIR%\.env.example"
echo APP_PORT=5000 >> "%PROJECT_DIR%\.env.example"
echo APP_HOST=0.0.0.0 >> "%PROJECT_DIR%\.env.example"
echo DEBUG=False >> "%PROJECT_DIR%\.env.example"

REM Создаем README.md
echo # Сокращатель ссылок > "%PROJECT_DIR%\README.md"
echo. >> "%PROJECT_DIR%\README.md"
echo Простой веб-сервис для сокращения URL с аналитикой >> "%PROJECT_DIR%\README.md"

echo Шаг 4: Создаю основные Python файлы...

REM Создаем database.py
echo from flask_sqlalchemy import SQLAlchemy > "%PROJECT_DIR%\src\database.py"
echo. >> "%PROJECT_DIR%\src\database.py"
echo db = SQLAlchemy() >> "%PROJECT_DIR%\src\database.py"

echo Шаг 5: Создаю HTML шаблоны...

REM Создаем index.html (упрощенная версия)
echo ^<!DOCTYPE html^> > "%PROJECT_DIR%\src\templates\index.html"
echo ^<html^> >> "%PROJECT_DIR%\src\templates\index.html"
echo ^<head^> >> "%PROJECT_DIR%\src\templates\index.html"
echo     ^<title^>Сокращатель ссылок^</title^> >> "%PROJECT_DIR%\src\templates\index.html"
echo     ^<style^> >> "%PROJECT_DIR%\src\templates\index.html"
echo         body { font-family: Arial; margin: 50px; } >> "%PROJECT_DIR%\src\templates\index.html"
echo         .container { max-width: 600px; margin: auto; } >> "%PROJECT_DIR%\src\templates\index.html"
echo         input, button { padding: 10px; margin: 5px; } >> "%PROJECT_DIR%\src\templates\index.html"
echo         .success { color: green; font-weight: bold; } >> "%PROJECT_DIR%\src\templates\index.html"
echo     ^</style^> >> "%PROJECT_DIR%\src\templates\index.html"
echo ^</head^> >> "%PROJECT_DIR%\src\templates\index.html"
echo ^<body^> >> "%PROJECT_DIR%\src\templates\index.html"
echo     ^<div class="container"^> >> "%PROJECT_DIR%\src\templates\index.html"
echo         ^<h1^>🔗 Сокращатель ссылок^</h1^> >> "%PROJECT_DIR%\src\templates\index.html"
echo         ^<form method="POST" action="/"^> >> "%PROJECT_DIR%\src\templates\index.html"
echo             ^<input type="url" name="url" placeholder="https://example.com" required style="width: 80%%;"^> >> "%PROJECT_DIR%\src\templates\index.html"
echo             ^<button type="submit"^>Сократить^</button^> >> "%PROJECT_DIR%\src\templates\index.html"
echo         ^</form^> >> "%PROJECT_DIR%\src\templates\index.html"
echo. >> "%PROJECT_DIR%\src\templates\index.html"
echo         {% if short_url %} >> "%PROJECT_DIR%\src\templates\index.html"
echo             ^<div class="success"^>Готово! Короткая ссылка: ^<a href="{{ short_url }}"^>{{ short_url }}^</a>^</div^> >> "%PROJECT_DIR%\src\templates\index.html"
echo             ^<p^>^<a href="{{ short_url }}/stats"^>📊 Посмотреть статистику^</a>^</p^> >> "%PROJECT_DIR%\src\templates\index.html"
echo         {% endif %} >> "%PROJECT_DIR%\src\templates\index.html"
echo     ^</div^> >> "%PROJECT_DIR%\src\templates\index.html"
echo ^</body^> >> "%PROJECT_DIR%\src\templates\index.html"
echo ^</html^> >> "%PROJECT_DIR%\src\templates\index.html"

echo Шаг 6: Создаю главный файл app.py...

REM Создаем app.py (упрощенная рабочая версия)
echo import os > "%PROJECT_DIR%\src\app.py"
echo import random >> "%PROJECT_DIR%\src\app.py"
echo import string >> "%PROJECT_DIR%\src\app.py"
echo from datetime import datetime >> "%PROJECT_DIR%\src\app.py"
echo from flask import Flask, render_template, request, redirect, jsonify >> "%PROJECT_DIR%\src\app.py"
echo from database import db >> "%PROJECT_DIR%\src\app.py"
echo. >> "%PROJECT_DIR%\src\app.py"
echo app = Flask(__name__) >> "%PROJECT_DIR%\src\app.py"
echo. >> "%PROJECT_DIR%\src\app.py"
echo # Настройки >> "%PROJECT_DIR%\src\app.py"
echo app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///./short_links.db' >> "%PROJECT_DIR%\src\app.py"
echo app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False >> "%PROJECT_DIR%\src\app.py"
echo app.config['SECRET_KEY'] = 'dev-key-123' >> "%PROJECT_DIR%\src\app.py"
echo. >> "%PROJECT_DIR%\src\app.py"
echo db.init_app(app) >> "%PROJECT_DIR%\src\app.py"
echo. >> "%PROJECT_DIR%\src\app.py"
echo # Модели БД прямо здесь для простоты >> "%PROJECT_DIR%\src\app.py"
echo class ShortLink(db.Model): >> "%PROJECT_DIR%\src\app.py"
echo     __tablename__ = 'short_links' >> "%PROJECT_DIR%\src\app.py"
echo     id = db.Column(db.Integer, primary_key=True) >> "%PROJECT_DIR%\src\app.py"
echo     original_url = db.Column(db.String(1000), nullable=False) >> "%PROJECT_DIR%\src\app.py"
echo     short_code = db.Column(db.String(10), unique=True, nullable=False) >> "%PROJECT_DIR%\src\app.py"
echo     created_at = db.Column(db.DateTime, default=datetime.utcnow) >> "%PROJECT_DIR%\src\app.py"
echo     click_count = db.Column(db.Integer, default=0) >> "%PROJECT_DIR%\src\app.py"
echo. >> "%PROJECT_DIR%\src\app.py"
echo class ClickStat(db.Model): >> "%PROJECT_DIR%\src\app.py"
echo     __tablename__ = 'click_stats' >> "%PROJECT_DIR%\src\app.py"
echo     id = db.Column(db.Integer, primary_key=True) >> "%PROJECT_DIR%\src\app.py"
echo     short_link_id = db.Column(db.Integer, db.ForeignKey('short_links.id')) >> "%PROJECT_DIR%\src\app.py"
echo     clicked_at = db.Column(db.DateTime, default=datetime.utcnow) >> "%PROJECT_DIR%\src\app.py"
echo     ip_address = db.Column(db.String(45)) >> "%PROJECT_DIR%\src\app.py"
echo. >> "%PROJECT_DIR%\src\app.py"
echo # Функция генерации короткого кода >> "%PROJECT_DIR%\src\app.py"
echo def generate_short_code(length=6): >> "%PROJECT_DIR%\src\app.py"
echo     chars = string.ascii_letters + string.digits >> "%PROJECT_DIR%\src\app.py"
echo     return ''.join(random.choice(chars) for _ in range(length)) >> "%PROJECT_DIR%\src\app.py"
echo. >> "%PROJECT_DIR%\src\app.py"
echo @app.route('/', methods=['GET', 'POST']) >> "%PROJECT_DIR%\src\app.py"
echo def index(): >> "%PROJECT_DIR%\src\app.py"
echo     if request.method == 'POST': >> "%PROJECT_DIR%\src\app.py"
echo         original_url = request.form.get('url', '').strip() >> "%PROJECT_DIR%\src\app.py"
echo         if not original_url.startswith(('http://', 'https://')): >> "%PROJECT_DIR%\src\app.py"
echo             original_url = 'https://' + original_url >> "%PROJECT_DIR%\src\app.py"
echo         >> "%PROJECT_DIR%\src\app.py"
echo         # Генерируем уникальный код >> "%PROJECT_DIR%\src\app.py"
echo         short_code = generate_short_code() >> "%PROJECT_DIR%\src\app.py"
echo         while ShortLink.query.filter_by(short_code=short_code).first(): >> "%PROJECT_DIR%\src\app.py"
echo             short_code = generate_short_code() >> "%PROJECT_DIR%\src\app.py"
echo         >> "%PROJECT_DIR%\src\app.py"
echo         # Сохраняем в БД >> "%PROJECT_DIR%\src\app.py"
echo         link = ShortLink(original_url=original_url, short_code=short_code) >> "%PROJECT_DIR%\src\app.py"
echo         db.session.add(link) >> "%PROJECT_DIR%\src\app.py"
echo         db.session.commit() >> "%PROJECT_DIR%\src\app.py"
echo         >> "%PROJECT_DIR%\src\app.py"
echo         short_url = f"http://localhost:5000/{short_code}" >> "%PROJECT_DIR%\src\app.py"
echo         return render_template('index.html', short_url=short_url) >> "%PROJECT_DIR%\src\app.py"
echo     >> "%PROJECT_DIR%\src\app.py"
echo     return render_template('index.html') >> "%PROJECT_DIR%\src\app.py"
echo. >> "%PROJECT_DIR%\src\app.py"
echo @app.route('/^<short_code^>') >> "%PROJECT_DIR%\src\app.py"
echo def redirect_link(short_code): >> "%PROJECT_DIR%\src\app.py"
echo     link = ShortLink.query.filter_by(short_code=short_code).first() >> "%PROJECT_DIR%\src\app.py"
echo     if not link: >> "%PROJECT_DIR%\src\app.py"
echo         return 'Ссылка не найдена', 404 >> "%PROJECT_DIR%\src\app.py"
echo     >> "%PROJECT_DIR%\src\app.py"
echo     # Записываем статистику >> "%PROJECT_DIR%\src\app.py"
echo     stat = ClickStat( >> "%PROJECT_DIR%\src\app.py"
echo         short_link_id=link.id, >> "%PROJECT_DIR%\src\app.py"
echo         ip_address=request.remote_addr >> "%PROJECT_DIR%\src\app.py"
echo     ) >> "%PROJECT_DIR%\src\app.py"
echo     link.click_count += 1 >> "%PROJECT_DIR%\src\app.py"
echo     db.session.add(stat) >> "%PROJECT_DIR%\src\app.py"
echo     db.session.commit() >> "%PROJECT_DIR%\src\app.py"
echo     >> "%PROJECT_DIR%\src\app.py"
echo     return redirect(link.original_url) >> "%PROJECT_DIR%\src\app.py"
echo. >> "%PROJECT_DIR%\src\app.py"
echo @app.route('/^<short_code^>/stats') >> "%PROJECT_DIR%\src\app.py"
echo def show_stats(short_code): >> "%PROJECT_DIR%\src\app.py"
echo     link = ShortLink.query.filter_by(short_code=short_code).first() >> "%PROJECT_DIR%\src\app.py"
echo     if not link: >> "%PROJECT_DIR%\src\app.py"
echo         return 'Ссылка не найдена', 404 >> "%PROJECT_DIR%\src\app.py"
echo     >> "%PROJECT_DIR%\src\app.py"
echo     stats = ClickStat.query.filter_by(short_link_id=link.id).all() >> "%PROJECT_DIR%\src\app.py"
echo     >> "%PROJECT_DIR%\src\app.py"
echo     html = f"^<h1^>Статистика для {short_code}^</h1^>" >> "%PROJECT_DIR%\src\app.py"
echo     html += f"^<p^>Оригинальный URL: {link.original_url}^</p^>" >> "%PROJECT_DIR%\src\app.py"
echo     html += f"^<p^>Всего кликов: {link.click_count}^</p^>" >> "%PROJECT_DIR%\src\app.py"
echo     html += "^<h2^>История кликов:^</h2^>" >> "%PROJECT_DIR%\src\app.py"
echo     html += "^<ul^>" >> "%PROJECT_DIR%\src\app.py"
echo     for stat in stats: >> "%PROJECT_DIR%\src\app.py"
echo         html += f"^<li^>{stat.clicked_at} - IP: {stat.ip_address}^</li^>" >> "%PROJECT_DIR%\src\app.py"
echo     html += "^</ul^>" >> "%PROJECT_DIR%\src\app.py"
echo     html += '^<br^>^<a href="/"^>Назад^</a^>' >> "%PROJECT_DIR%\src\app.py"
echo     return html >> "%PROJECT_DIR%\src\app.py"
echo. >> "%PROJECT_DIR%\src\app.py"
echo @app.route('/api/shorten', methods=['POST']) >> "%PROJECT_DIR%\src\app.py"
echo def api_shorten(): >> "%PROJECT_DIR%\src\app.py"
echo     data = request.get_json() >> "%PROJECT_DIR%\src\app.py"
echo     if not data or 'url' not in data: >> "%PROJECT_DIR%\src\app.py"
echo         return jsonify({'error': 'URL is required'}), 400 >> "%PROJECT_DIR%\src\app.py"
echo     >> "%PROJECT_DIR%\src\app.py"
echo     original_url = data['url'].strip() >> "%PROJECT_DIR%\src\app.py"
echo     if not original_url.startswith(('http://', 'https://')): >> "%PROJECT_DIR%\src\app.py"
echo         original_url = 'https://' + original_url >> "%PROJECT_DIR%\src\app.py"
echo     >> "%PROJECT_DIR%\src\app.py"
echo     short_code = generate_short_code() >> "%PROJECT_DIR%\src\app.py"
echo     while ShortLink.query.filter_by(short_code=short_code).first(): >> "%PROJECT_DIR%\src\app.py"
echo         short_code = generate_short_code() >> "%PROJECT_DIR%\src\app.py"
echo     >> "%PROJECT_DIR%\src\app.py"
echo     link = ShortLink(original_url=original_url, short_code=short_code) >> "%PROJECT_DIR%\src\app.py"
echo     db.session.add(link) >> "%PROJECT_DIR%\src\app.py"
echo     db.session.commit() >> "%PROJECT_DIR%\src\app.py"
echo     >> "%PROJECT_DIR%\src\app.py"
echo     return jsonify({ >> "%PROJECT_DIR%\src\app.py"
echo         'original_url': original_url, >> "%PROJECT_DIR%\src\app.py"
echo         'short_code': short_code, >> "%PROJECT_DIR%\src\app.py"
echo         'short_url': f'http://localhost:5000/{short_code}' >> "%PROJECT_DIR%\src\app.py"
echo     }) >> "%PROJECT_DIR%\src\app.py"
echo. >> "%PROJECT_DIR%\src\app.py"
echo if __name__ == '__main__': >> "%PROJECT_DIR%\src\app.py"
echo     with app.app_context(): >> "%PROJECT_DIR%\src\app.py"
echo         db.create_all() >> "%PROJECT_DIR%\src\app.py"
echo     app.run(debug=True, host='0.0.0.0', port=5000) >> "%PROJECT_DIR%\src\app.py"

echo Шаг 7: Создаю run.bat для запуска...
echo @echo off > "%PROJECT_DIR%\run.bat"
echo echo Установка зависимостей... >> "%PROJECT_DIR%\run.bat"
echo pip install flask flask-sqlalchemy python-dotenv shortuuid user-agents validators >> "%PROJECT_DIR%\run.bat"
echo. >> "%PROJECT_DIR%\run.bat"
echo echo Запуск сервера... >> "%PROJECT_DIR%\run.bat"
echo echo Откройте браузер и перейдите по адресу: http://localhost:5000 >> "%PROJECT_DIR%\run.bat"
echo echo. >> "%PROJECT_DIR%\run.bat"
echo python src\app.py >> "%PROJECT_DIR%\run.bat"
echo pause >> "%PROJECT_DIR%\run.bat"

echo Шаг 8: Создаю ярлык для запуска...
echo @echo off > "%PROJECT_DIR%\start.bat"
echo cd /d "%%~dp0" >> "%PROJECT_DIR%\start.bat"
echo start run.bat >> "%PROJECT_DIR%\start.bat"

echo Шаг 9: Создаю ярлык на рабочем столе...
echo [InternetShortcut] > "%USERPROFILE%\Desktop\Открыть сокращатель.url"
echo URL=http://localhost:5000 >> "%USERPROFILE%\Desktop\Открыть сокращатель.url"
echo IconFile=C:\Windows\System32\SHELL32.dll >> "%USERPROFILE%\Desktop\Открыть сокращатель.url"
echo IconIndex=14 >> "%USERPROFILE%\Desktop\Открыть сокращатель.url"

echo.
echo ========================================
echo   ПРОЕКТ УСПЕШНО СОЗДАН!
echo ========================================
echo.
echo Папка проекта: %PROJECT_DIR%
echo.
echo ЧТО ДЕЛАТЬ ДАЛЬШЕ:
echo 1. Откройте папку проекта: %PROJECT_DIR%
echo 2. Дважды кликните на файл 'start.bat'
echo 3. Откройте браузер
echo 4. Перейдите по адресу: http://localhost:5000
echo.
echo ИЛИ просто кликните на ярлык 'Открыть сокращатель' на рабочем столе
echo.
pause