# DrillSight Technical Showcase – FastAPI Container
# Note: This image exposes the public API and infrastructure only.
# Core ML models and drill analysis logic live in a separate private repo.

FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# System deps (only what is reasonably needed for a FastAPI app)
RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code (excluding ML-private repos)
COPY . .

# Environment defaults (can be overridden at runtime)
ENV DRILLSIGHT_ENV=production \
    REDIS_URL=redis://redis:6379/0

# FastAPI app entrypoint
# Uses the technical-showcase FastAPI app defined in app/fastapi_app.py
EXPOSE 8000

CMD ["uvicorn", "app.fastapi_app:app", "--host", "0.0.0.0", "--port", "8000"]
