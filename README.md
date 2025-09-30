# Bookboxd - Library Management System

### Running Steps When running for a first time

1. **Building and running the application **
   ```bash
   # First run the mi_ssl_generator script
   docker-compose build mi_ssl_generator

   # After it is build run the whole docker-compose
   docker-compose up -d
   ```
   
then open "https://martin-infra3.duckdns.org/"
   
## Project Requirements Checklist

✅ **Deployable locally with DNS switching**
- The application can be deployed locally using Docker Compose

✅ **Docker Compose**
- The project uses Docker Compose for orchestrating multiple containers
- Configuration is in `docker-compose.yml` at the root of the project

✅ **Multi-stage build**
- The main application Dockerfile uses multi-stage build:
  - First stage: Build the application with Gradle
  - Second stage: Create a runtime image with only necessary components

✅ **SQL database in separate container**
- PostgreSQL database runs in a dedicated container (`mi_books_db`)
- Data persistence through Docker volumes

✅ **Reverse proxy in separate container**
- Nginx serves as reverse proxy in `mi_books_reverse_proxy` container
- Handles routing and SSL termination

✅ **SSL/TLS termination with valid certificate**
- Let's Encrypt certificates are automatically generated and renewed
- SSL termination happens at the reverse proxy level

✅ **Path-based routing to multiple containers**
- Nginx configuration routes to:
  - `/` → Main application (`mi_books_app`)
  - `/movies` → Movies application (`mi_movies_app`)

✅ **Container naming convention**
- All containers, networks, and volumes include the prefix `mi_` (Martin Ivanov)
- Examples: `mi_books_app`, `mi_books_db`, `mi_books_frontend_network`

✅ **Environment variables**
- Stored in `.env` file at the project root
- Used for database credentials, domain configuration, and service parameters

✅ **Network configuration**
- Project uses two Docker networks:
  - `mi_books_frontend_network`: For public-facing services
  - `mi_books_backend_network`: For internal database communication

✅ **Documentation in repository**
- Comprehensive README with deployment instructions and architecture details

## Project Overview
Bookboxd is a web application designed to help users track books they've read and share reviews. It's inspired by the "Letterboxd" concept but for books instead of films. The application allows users to add books to a collection, view all books in the library, and leave ratings and reviews.

## Technology Stack

### Infrastructure & Deployment
- **Docker** - Containerization
- **Docker Compose** - Multi-container deployment
- **Nginx** - Reverse proxy and SSL termination
- **Let's Encrypt** - Free, automated SSL certificates
- **DuckDNS** - Dynamic DNS service

## Key Features
- **Home Page**: Attractive landing page with animated book elements
- **Add Book**: Form to add new books with title, description, and rating
- **View Books**: List all books with their details and ratings
- **Secure Access**: HTTPS with valid SSL certificates
- **Remote Access**: Public domain name through DuckDNS

## Project Structure

### Backend Components
- **Domain Layer**: Contains entity classes like Book and Customer
- **Repository Layer**: Data access interfaces
- **Service Layer**: Business logic implementation
- **Controller Layer**: HTTP request handling

### Frontend Components
- **Templates**: Thymeleaf HTML templates (index.html, allbooks.html, addbook.html)
- **Static Resources**:
    - CSS files for styling
    - JavaScript for interactive elements and animations
    - Images and other media assets

### Docker Implementation Details

The project uses Docker Compose to orchestrate multiple containers:

1. **Docker Compose Configuration**
    - The project is deployable both locally and on a public domain
    - File: `docker-compose.yml` at the root of the project

2. **Container Structure**
    - `mi_books_app`: Spring Boot application container
    - `mi_books_db`: PostgreSQL database container
    - `mi_books_reverse_proxy`: Nginx reverse proxy container
    - `mi_movies_app`: Secondary application for routing demonstration
    - `mi_SSL_generator`: Let's Encrypt certificate generation container

3. **Multi-stage Build**
    - The application Dockerfile uses multi-stage build to optimize the final image size
    - First stage builds the application
    - Second stage creates a runtime image with only necessary components

4. **Database Implementation**
    - PostgreSQL database runs in a separate container (`mi_books_db`)
    - Uses persistent volume for data storage (`mi_books_db_data`)
    - Health checks ensure the database is ready before application startup

5. **Reverse Proxy Features**
    - Nginx reverse proxy in a separate container (`mi_books_reverse_proxy`)
    - SSL/TLS termination with valid Let's Encrypt certificates
    - Path-based routing to multiple services:
        - Main - Book application (`mi_books_app`)
        - Movies application (`mi_movies_app`)
    - Security headers and modern SSL configuration

6. **SSL Certificate Management**
    - Automatic certificate generation and renewal using Certbot
    - DNS-based challenge verification through DuckDNS
    - Java keystore generation for Spring Boot application
    - Service dependencies ensure certificates are ready before app startup

7. **Naming Convention**
    - All container names, networks, and volumes include the prefix `mi_` (Martin Ivanov)
    - Examples: `mi_books_app`, `mi_books_frontend_network`, `mi_books_db_data`

8. **Environment Variables**
    - Stored in `.env` file at the root of the project
    - Used for database connection parameters, ports, domain name, and DuckDNS token
    - Enables easy configuration changes without modifying Docker Compose files

9. **Network Configuration**
    - Two separate networks for security:
        - `mi_books_frontend_network`: For public-facing services
        - `mi_books_backend_network`: For internal communication between app and database

## Getting Started

### Prerequisites
- Docker and Docker Compose
- JDK 21 (for development)
- Gradle (included as wrapper)
- DuckDNS subdomain and token (for public deployment)

### Running Locally
1. Navigate to the project directory
2. Update the `.env` file with your DuckDNS subdomain and token
3. Run `docker-compose up -d`
4. Access the application at https://martin-infra3.duckdns.org/

### Deploying Publicly
1. Ensure port 80 and 443 are open on your router/firewall
2. Set up port forwarding to your machine
3. Update the `.env` file with your DuckDNS subdomain and token
4. Run `docker-compose up -d`
5. Access the application at https://martin-infra3.duckdns.org/

## Security Features
- HTTPS support with automatically generated Let's Encrypt certificates
- Secure reverse proxy configuration with modern SSL ciphers
- HTTP security headers (HSTS, X-Frame-Options, etc.)
- Environment variable-based configuration
- Separation of frontend and backend networks


## Troubleshooting
- Check Docker logs with `docker-compose logs`
- Certificate generation logs are in `log/letsencrypt/letsencrypt.log`
- Ensure your DuckDNS subdomain is correctly pointing to your public IP

## Project Contributors
- Martin Ivanov
