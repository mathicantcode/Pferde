# syntax=docker/dockerfile:1

FROM python:3.11-slim

# 1. Basis-Einstellungen
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# 2. System‑Pakete (nur falls nötig)
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
    && rm -rf /var/lib/apt/lists/*

# 3. Arbeitsverzeichnis
WORKDIR /app

# 4. Nur requirements kopieren und installieren (schont den Cache)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. Restliche App hinzufügen
COPY . .

# 6. Port freigeben
EXPOSE 8501

# 7. Startbefehl
ENTRYPOINT ["streamlit", "run"]
CMD ["main.py", "--server.port=8501", "--server.address=0.0.0.0"]