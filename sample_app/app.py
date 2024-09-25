from flask import Flask, render_template_string
import os
import yaml
import argparse

app = Flask(__name__)

@app.route('/')
def home():
    html = '''
    <!DOCTYPE html>
    <html lang="zh-CN">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Serv00 部署成功</title>
        <style>
            body {
                font-family: 'Arial', sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                background-color: #f0f2f5;
            }
            .container {
                text-align: center;
                padding: 2rem;
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }
            h1 {
                color: #4a4a4a;
                margin-bottom: 1rem;
            }
            p {
                color: #666;
            }
            .success-icon {
                font-size: 4rem;
                color: #28a745;
                margin-bottom: 1rem;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="success-icon">&#10004;</div>
            <h1>Serv00 应用部署成功</h1>
            <p>恭喜！您的 Flask 应用已成功部署在 Serv00 上。</p>
            <h3>访问部署详情页 <a href="http://{{ request.host }}/info.html">访问详情页</a></h3>
        </div>
    </body>
    </html>
    '''
    
    return render_template_string(html)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--port', type=int, default=5000)
    parser.add_argument('--host', type=str, default='0.0.0.0')
    args = parser.parse_args()
    
    app.run(host=args.host, port=args.port, debug=True)