import uvicorn
import logging

# Configure logging before starting uvicorn
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s [%(levelname)s] %(name)s - %(message)s',
    force=True  # This will override any existing logging configuration
)

if __name__ == "__main__":
    uvicorn.run(
        "app.main:app",
        host="0.0.0.0",
        port=8000,
        reload=True,
        log_level="info",
        log_config=None  # This will prevent uvicorn from overriding our logging config
    ) 