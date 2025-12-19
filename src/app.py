from flask import Flask, request, redirect, render_template_string,render_template
import random, string, datetime

app = Flask(__name__)
links, stats = {}, {}

HTML = '''
<!DOCTYPE html>
<html>
<head><title>Сокращатель</title>
<style>
body{font-family:Arial;max-width:600px;margin:40px auto;padding:20px}
input{padding:10px;width:70%;margin-right:10px}
button{padding:10px 20px;background:#28a745;color:white;border:none}
.result{background:#d4edda;padding:15px;margin:20px 0}
</style>
</head>
<body>
<h1>🔗 Сокращатель ссылок</h1>
<form method="POST" action="/shorten">
<input type="url" name="url" placeholder="https://example.com" required>
<button type="submit">Сократить</button>
</form>
%s
</body>
</html>
'''

@app.route('/')
def home():
    return HTML.replace("%s", "")

@app.route('/shorten', methods=['POST'])
def shorten():
    url = request.form['url']
    if not url.startswith(('http://','https://')):
        url = 'https://' + url

    code = ''.join(random.choices(string.ascii_letters + string.digits, k=6))
    links[code] = url
    stats[code] = {'clicks': 0, 'created': datetime.datetime.now()}

    result = f'''
    <div class="result">
    <h3>✅ Ссылка создана!</h3>
    <p><strong>Короткая:</strong> <a href="/{code}">http://localhost:5000/{code}</a></p>
    <p><strong>Оригинальная:</strong> {url[:50]}...</p>
    <p><a href="/{code}/stats">📊 Статистика</a> | <a href="/">Создать ещё</a></p>
    </div>
    '''
    return HTML.replace("%s", result)

@app.route('/<code>')
def redirect_link(code):
    if code in links:
        stats[code]['clicks'] += 1
        return redirect(links[code])
    return 'Ссылка не найдена', 404

@app.route('/<code>/stats')
def show_stats(code):
    if code not in links: return 'Не найдено', 404
    stat = stats[code]
    stats_html = f'''
    <h2>📊 Статистика для {code}</h2>
    <p>Кликов: <strong>{stat['clicks']}</strong></p>
    <p>Создана: {stat['created'].strftime('%%d.%%m.%%Y %%H:%%M')}</p>
    <p>Ведёт на: <a href="{links[code]}">{links[code][:60]}...</a></p>
    <p><a href="/">← На главную</a></p>
    '''
    return HTML.replace("%s", stats_html)


if __name__ == '__main__':
    print('\n' + '='*50)
    print('Сервер запущен!')
    print('Откройте браузер и перейдите по адресу:')
    print('👉 http://localhost:5000 👈')
    print('='*50 + '\n')
    app.run(host='0.0.0.0', port=5000, debug=True)