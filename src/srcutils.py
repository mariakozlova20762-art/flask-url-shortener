import random
import string
import validators
import ipaddress

def generate_short_code(length=8):
    """Генерация случайного короткого кода"""
    characters = string.ascii_letters + string.digits
    return ''.join(random.choice(characters) for _ in range(length))

def is_valid_url(url):
    """Проверка валидности URL"""
    return validators.url(url)

def get_client_ip(request):
    """Получение IP-адреса клиента"""
    # Пробуем получить IP из заголовков прокси
    if request.headers.get('X-Forwarded-For'):
        ip = request.headers.get('X-Forwarded-For').split(',')[0].strip()
    elif request.headers.get('X-Real-IP'):
        ip = request.headers.get('X-Real-IP')
    else:
        ip = request.remote_addr
    
    # Проверяем валидность IP
    try:
        ipaddress.ip_address(ip)
        return ip
    except ValueError:
        return None

def format_datetime(dt, format='%Y-%m-%d %H:%M:%S'):
    """Форматирование даты и времени"""
    if dt:
        return dt.strftime(format)
    return ''