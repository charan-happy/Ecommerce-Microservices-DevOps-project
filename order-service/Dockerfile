FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py . && tests/ ./tests/
EXPOSE 5000

ENTRYPOINT ["python3", "app.py"]
