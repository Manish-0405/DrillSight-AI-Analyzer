# DrillSight Technical Showcase – Repository Structure

This document describes a **public-facing, production-minded** repository layout for DrillSight. The intent is to communicate engineering maturity (APIs, deployment, observability, MLOps) while keeping the **core ML models and proprietary analysis logic** in a separate private repository.

```text
.
├── app/
│   ├── api/
│   │   ├── main.py              # FastAPI entrypoint (no ML internals)
│   │   └── routers/             # Versioned API routers (health, analyze, feedback)
│   ├── core/
│   │   ├── config.py            # Settings / environment management
│   │   └── logging.py           # Structured logging setup
│   ├── services/
│   │   ├── inference_client.py  # Interfaces to private ML inference service
│   │   ├── analysis_client.py   # Interfaces to drill analyzers (private repo)
│   │   └── cache.py             # Redis cache wrapper
│   └── schemas/
│       ├── requests.py          # Pydantic models for input payloads
│       └── responses.py         # Pydantic models for output/feedback
│
├── api-wrappers/
│   ├── python/
│   │   └── drillsight_client.py # Example Python SDK for the public API
│   └── javascript/
│       └── drillsightClient.ts  # Example JS/TS client for web integration
│
├── docs/
│   ├── architecture/
│   │   ├── system_design.md     # Expanded architecture and diagrams
│   │   └── cv_pipeline.md       # Computer vision pipeline explanation
│   ├── mlops/
│   │   ├── mlops_pipeline.md    # Data, training, registry, CI/CD
│   │   └── monitoring.md        # Metrics, logging, and alerting design
│   └── product-brief.md         # One-page problem/solution for non-technical readers
│
├── deployment/
│   ├── docker/
│   │   ├── Dockerfile           # FastAPI container (this repo)
│   │   └── docker-compose.yml   # API + Redis + (optional) monitoring stack
│   └── k8s/
│       ├── api-deployment.yaml  # Kubernetes Deployment for API
│       ├── api-service.yaml     # Service / Ingress config
│       └── redis.yaml           # Redis Deployment/Service
│
├── scripts/
│   ├── bootstrap_dev.sh         # Dev env setup (migrations, seed data)
│   ├── run_checks.sh            # Linting, typing, and unit tests
│   └── export_openapi.py        # Export OpenAPI schema for clients
│
├── tests/
│   ├── unit/
│   │   ├── test_api_contracts.py    # Ensure API contracts remain stable
│   │   └── test_schemas.py          # Validate Pydantic models
│   └── integration/
│       └── test_full_flow.py        # End-to-end with mocked ML layer
│
├── .github/
│   └── workflows/
│       ├── ci.yml                # Lint + tests + build Docker image
│       └── cd.yml                # Deploy to staging/prod (optional)
│
├── .env.example                 # Example environment variables
├── README.md                    # High-level overview and architecture
└── project_structure.md         # This document
```

## Folder-by-folder Intent

- **app/** – All application code for the public DrillSight API.
  - `api/` keeps FastAPI routing thin and declarative.
  - `core/` centralizes configuration and logging concerns.
  - `services/` defines clear interfaces to **private** ML services and analyzers.
  - `schemas/` documents and enforces strict request/response contracts.

- **api-wrappers/** – Lightweight SDKs / clients that demonstrate how a production client would consume the DrillSight API. This helps recruiters see that you think beyond the backend.

- **docs/** – Architecture and process documentation:
  - `architecture/` explains the system design with Mermaid diagrams.
  - `mlops/` captures the full ML lifecycle and operational playbook.
  - `product-brief.md` is for non-technical stakeholders.

- **deployment/** – Production deployment artifacts:
  - `docker/` for local dev and simple server deployments.
  - `k8s/` manifests for cluster-based deployments with Redis and API.

- **scripts/** – Operational scripts to automate repetitive tasks (setup, checks, schema export). These embody a **DevOps mindset**.

- **tests/** – Unit and integration tests for the public-facing code and contracts, using **mocked ML layers** so core models remain private.

- **.github/workflows/** – CI/CD pipelines to run checks, tests, and optionally deploy containers.

- **.env.example** – Template for runtime configuration (API keys, Redis URL, model endpoint URLs).

This conceptual structure lets you:
- Showcase a **production-ready mindset** (APIs, infra, CI/CD, MLOps).
- Cleanly separate **public contracts** from **private ML implementations**.
- Give recruiters a clear mental model of how DrillSight would run in a real environment.
