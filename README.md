# AURORA Resume Agent - Full Stack AI-Powered Resume Analysis

A futuristic, interactive resume analysis system powered by advanced AI agents. Built with Next.js frontend and FastAPI backend, featuring a beautiful pearl white theme and intelligent document processing.

## ✨ Features

### Frontend
- **Futuristic UI/UX**: Modern, interactive design with smooth animations
- **Pearl White Theme**: Elegant color scheme with glassmorphism effects
- **Responsive Design**: Works seamlessly on all devices
- **Interactive Elements**: Hover effects, animations, and smooth transitions
- **Drag & Drop**: Intuitive file upload interface

### Backend
- **Intelligent AI Agent**: Powered by Google Gemini 1.5 Pro
- **Advanced Prompt Engineering**: Sophisticated prompts for accurate parsing
- **Multi-Format Support**: PDF, DOCX, and TXT files
- **Comprehensive Analysis**: Personal info, experience, education, skills, and insights
- **Strategic Recommendations**: Career insights and improvement suggestions

## 🚀 Quick Start

### Prerequisites
- Python 3.8+
- Node.js 18+
- Google AI API Key

### Backend Setup

1. **Navigate to backend directory:**
   ```bash
   cd backend_fastapi
   ```

2. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

3. **Set environment variables:**
   ```bash
   # Create .env file
   echo "GOOGLE_API_KEY=your_google_ai_api_key_here" > .env
   ```

4. **Run the backend:**
   ```bash
   python app.py
   ```
   
   The API will be available at `http://localhost:8000`

### Frontend Setup

1. **Navigate to frontend directory:**
   ```bash
   cd frontend_nextjs
   ```

2. **Install dependencies:**
   ```bash
   npm install
   ```

3. **Run the frontend:**
   ```bash
   npm run dev
   ```
   
   The app will be available at `http://localhost:3000`

## 🏗️ Architecture

### Frontend (Next.js 14)
- **Framework**: Next.js with App Router
- **Styling**: Tailwind CSS with custom pearl theme
- **Animations**: Framer Motion for smooth interactions
- **State Management**: React hooks for local state
- **File Handling**: React Dropzone for drag & drop

### Backend (FastAPI)
- **Framework**: FastAPI with async support
- **AI Engine**: Google Gemini 1.5 Pro via LangChain
- **Document Processing**: PyPDF2, python-docx for text extraction
- **Data Models**: Pydantic for structured output
- **Error Handling**: Comprehensive error handling and fallbacks

## 🔧 API Endpoints

### Core Endpoints
- `GET /` - API information and status
- `GET /health` - Health check
- `POST /parse_resume` - Resume parsing and analysis
- `GET /agent_status` - Agent capabilities and status

### Resume Analysis Response
The API returns structured data including:
- Personal information
- Work experience with achievements
- Education and certifications
- Technical and soft skills
- Professional summary
- Key strengths
- Improvement suggestions
- Industry fit assessment

## 🎨 Design System

### Color Palette
- **Primary**: Pearl white variations (#fefefe to #404040)
- **Accents**: Blue, purple, emerald gradients
- **Text**: Slate variations for readability
- **Backgrounds**: Subtle gradients with transparency

### UI Components
- Glassmorphism cards with backdrop blur
- Smooth hover animations and transitions
- Interactive buttons with state feedback
- Responsive grid layouts
- Custom scrollbars and focus states

## 🤖 AI Agent Capabilities

### Intelligent Parsing
- **Context Awareness**: Understands resume structure and content
- **Pattern Recognition**: Identifies career progression and skills
- **Strategic Analysis**: Provides actionable career insights
- **Quality Assessment**: Suggests improvements and optimizations

### Advanced Features
- **Multi-format Support**: Handles various document formats
- **Error Recovery**: Fallback mechanisms for parsing failures
- **Metadata Extraction**: Comprehensive information gathering
- **Professional Insights**: Industry-specific recommendations

## 📱 User Experience

### Homepage
- Interactive agent cardholder with hover effects
- Feature highlights with animated icons
- Smooth page transitions and loading states

### Agent Page
- **Left Panel**: Agent activation and file upload
- **Right Panel**: Parsed content display with categorization
- **Real-time Feedback**: Processing states and error handling
- **Responsive Layout**: Adapts to different screen sizes

## 🔒 Security & Performance

### Security Features
- CORS configuration for frontend integration
- File type validation and sanitization
- Temporary file handling with cleanup
- Error message sanitization

### Performance Optimizations
- Async file processing
- Efficient text extraction algorithms
- Memory-conscious document handling
- Optimized AI prompt engineering

## 🚀 Deployment

### Backend Deployment
```bash
# Using uvicorn
uvicorn app:app --host 0.0.0.0 --port 8000

# Using gunicorn (production)
gunicorn app:app -w 4 -k uvicorn.workers.UvicornWorker
```

### Frontend Deployment
```bash
# Build for production
npm run build

# Start production server
npm start
```

### Environment Variables
```bash
# Backend
GOOGLE_API_KEY=your_google_ai_api_key

# Frontend
NEXT_PUBLIC_API_BASE=http://localhost:8000
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Google AI for Gemini 1.5 Pro
- LangChain for AI framework
- Next.js and FastAPI communities
- Tailwind CSS for styling utilities

## 📞 Support

For support and questions:
- Create an issue in the repository
- Check the API documentation at `/docs` when running the backend
- Review the health endpoint for system status

---

**AURORA Resume Agent** - Transforming resume analysis with the power of AI ✨
