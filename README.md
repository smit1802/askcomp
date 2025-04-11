# AskComp - Compliance Query Assistant

A compliance assistance bot that provides guidance on regulatory requirements.

## Features

- Natural language processing of compliance queries
- Structured responses with applicable circulars, activities, and implementation steps
- Web-based interface with conversation history
- Team-specific compliance guidance
- Dark/light mode support

## Architecture

AskComp consists of two main components:

1. **Backend API (FastAPI)**: Processes compliance queries and provides structured responses
2. **Web Frontend (Next.js)**: Provides a user-friendly interface for interacting with the compliance assistant

## Setup and Installation

### Backend Setup

1. Clone this repository
2. Install dependencies:

```bash
pip install -r requirements.txt
```

3. Set up environment variables in a `.env` file:

```
DATABASE_URL=sqlite:///./data/askcomp.db
OPENAI_API_KEY=your_openai_api_key
```

4. Run the backend server:

```bash
uvicorn app.main:app --reload
```

### Frontend Setup

1. Navigate to the frontend directory:

```bash
cd frontend/askcomp-frontend
```

2. Install dependencies:

```bash
npm install
```

3. Create a `.env.local` file with your backend URL:

```
NEXT_PUBLIC_BACKEND_URL=http://localhost:8000
```

4. Start the development server:

```bash
npm run dev
```

5. Open [http://localhost:3000](http://localhost:3000) to access the application.

## Web Frontend Features

The AskComp web interface provides:

- Beautiful, modern glassmorphic UI
- Dark/light mode toggle
- Team selection (Product, Tech)
- Response detail level selection (Summarised, Detailed)
- Conversation history and management
- Structured display of compliance information

## Deployment

### Backend Deployment

Deploy the FastAPI backend to a server or cloud platform (e.g., AWS, GCP, Azure, or Digital Ocean).

### Frontend Deployment

The easiest way to deploy the frontend is using Vercel:

1. Push your code to a GitHub repository
2. Import the project into Vercel
3. Set the environment variable `NEXT_PUBLIC_BACKEND_URL` to your backend URL
4. Deploy

## API Endpoints

- `POST /api/compliance/query` - Process a compliance query (legacy endpoint)
- `POST /api/chat` - Process a chat message from the web frontend
- `GET /api/conversations` - List all conversations
- `GET /api/conversations/{conversation_id}` - Get a specific conversation

## Previous Slack Integration

Previously, AskComp was integrated with Slack. The web frontend has now replaced this integration, providing a more flexible and customizable user experience.

If you need to restore the Slack integration, refer to earlier versions of the codebase. 