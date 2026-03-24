from typing import List, Optional, Dict, Any

from pydantic import BaseModel


class AnalyzeRequest(BaseModel):
    """Incoming payload for starting a drill analysis job.

    Intentionally generic so the public contract is clear
    without exposing proprietary internal schema details.
    """

    drill_type: str
    cadet_id: Optional[str] = None
    video_url: Optional[str] = None
    metadata: Optional[Dict[str, Any]] = None


class FeedbackItem(BaseModel):
    """Single feedback item returned to the client."""

    timestamp: float
    message: str
    severity: str


class AnalyzeResponse(BaseModel):
    """High-level response for an analysis request.

    In a real system this would likely be asynchronous and
    return just a job_id, with detailed feedback fetched
    from a separate endpoint once processing completes.
    """

    job_id: str
    status: str
    overall_score: Optional[float] = None
    feedback: List[FeedbackItem] = []


class HealthResponse(BaseModel):
    """Health check response schema."""

    status: str
    service: str
    environment: str
