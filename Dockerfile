FROM python:3.11-slim

# Create a non-root user to run the application
RUN groupadd -r appuser && useradd -r -g appuser appuser

WORKDIR /app

COPY setup.py .
COPY requirements.txt .
COPY app/ ./app/

# Merge RUN statements and install dependencies
RUN pip install --no-cache-dir -r requirements.txt && \
    pip install -e . && \
    chown -R appuser:appuser /app

# Switch to non-root user
USER appuser

CMD ["python", "-m", "app.main"]
