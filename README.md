# 🔗 URL Shortener (Flask + Docker)

Сокращатель ссылок на Flask с PostgreSQL и Redis.

---

## 🚀 Запуск БЕЗ Docker (локально)

### Требования
- Python 3.11+
- Windows

### Запуск
```bat
start.bat

## 🚀 Запуск через Docker 

### Запуск
```bat
start-docker.bat

## 🚀 Запуск через 'CMD' 
docker compose up --build

## Структура проекта 

app/
├── src/
│   ├── app.py
│   ├── srcdatabase.py
│   ├── srcmodels.py
│   ├── srcutils.py
│   ├── templates/
│   └── static/
├── Dockerfile
├── docker-compose.yml
├── requirements.txt
├── start.bat
├── docker-start.bat
└── README.md

