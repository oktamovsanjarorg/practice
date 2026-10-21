FROM python:3.11-alpine

WORKDIR /app

# Best practice: Konteyner root foydalanuvchisi sifatida ishlamasligi kerak
RUN adduser -D -u 1001 appuser && chown -R appuser:appuser /app
COPY --chown=appuser:appuser main.py .

# Xavfsiz appuser nomidan ishga tushirish
USER appuser

CMD ["python", "main.py"]
