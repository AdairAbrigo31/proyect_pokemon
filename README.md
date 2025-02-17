# Pokemon Evolution Project 🌟

A full-stack application that allows users to manage their favorite Pokemon and evolve them. Built with Node.js (backend) and Flutter (frontend).

## 🚀 Getting Started

### Prerequisites
- Docker and Docker Compose
- Node.js
- Flutter
- Git

## 🗄️ Backend Setup

### 1. Database Setup with Docker
```shell
# Pull and run MySQL container
docker run -d \
 --name mysql_pokemon \
 -e MYSQL_ROOT_PASSWORD=your_password \
 -e MYSQL_DATABASE=pokemon_db \
 -p 3306:3306 \
 mysql:latest
```

### 2. Backend Configuration
```shell
# Clone the repository
git clone <repository-url>
cd pokemon_backend

# Install dependencies
npm install

# Create .env file
touch .env
```

## Config your .env
```properties
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_DATABASE=pokemon_db
JWT_SECRET=your_secret_key
PORT=3000
```

## Run the backend
```shell
 node src/app.js
```


### 3. Frontend configuration
```shell
cd pokemon_frontend

# Install dependencies
flutter pub get

flutter run
```

📌 API Endpoints
Authentication
```http
POST /api/auth/register - Register new user
POST /api/auth/login - User login
```

Pokemons
```http
POST /api/auth/register - Register new user
POST /api/auth/login - User login
```
