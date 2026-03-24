# DrillSight System Design – Technical Showcase

This document complements the main README and focuses on **how** DrillSight is architected as a production-ready system, without revealing proprietary ML implementations.

## Goals

- Separate **public contracts** (APIs, schemas, deployment) from **private ML logic**.
- Show a clear, scalable architecture for computer-vision workloads.
- Demonstrate an MLOps mindset: experiment tracking, model versioning, CI/CD, and monitoring.

## High-Level Components

- **API Layer (FastAPI)** – Stateless HTTP interface for health checks, analysis requests, and feedback retrieval.
- **Processing Layer** – Orchestrates preprocessing, inference, and drill-specific analysis (resides in private repo).
- **Data & State** – Databases, caches (Redis), and model registry.
- **Observability** – Centralized logs and metrics for latency, errors, and data drift.

For a visual overview, see `docs/architecture_diag.png` (intentionally allowed through `.gitignore` as the only image).

## Request Lifecycle (Conceptual)

1. **Client → API**: A client sends an `/analyze` request with drill type, video location, and metadata.
2. **API → Orchestrator**: The API validates input and enqueues a background job.
3. **Orchestrator → CV Pipeline**: The private DrillSight pipeline handles decoding, pose estimation, and drill analyzers.
4. **Pipeline → Storage**: Metrics and feedback are persisted to a database/cache.
5. **Client → Feedback**: The client calls `/feedback/{job_id}` to retrieve final scores and comments.

## Deployment View

- Containerized FastAPI app (see `Dockerfile`).
- `docker-compose.yml` wiring API + Redis for local development.
- Optionally extend to Kubernetes using manifests under `deployment/` in a future iteration.

This file is deliberately high-level so you can safely share it in a public technical showcase repository.
