# HBnB Part 3 — Authentication and Database Persistence

## 📝 Description
Part 3 extends the HBnB backend with authentication, authorization, password hashing, and relational database persistence using SQLAlchemy and SQLite (for development) alongside MySQL preparation (for production).

This version replaces the in-memory repository layer from Part 2 with SQLAlchemy ORM models, persistent database tables, relational foreign keys, JWT authentication, and SQL setup scripts.

The application manages four core entities:
* **Users**
* **Places**
* **Reviews**
* **Amenities**

---

## 💻 Technology Stack
* **Language:** Python 3
* **Framework:** Flask & Flask-RESTx
* **ORM & Database:** Flask-SQLAlchemy, SQLAlchemy ORM, SQLite3 / MySQL
* **Security & Auth:** Flask-Bcrypt (Password Hashing), Flask-JWT-Extended (Authentication & Authorization)
* **Testing:** unittest
* **Diagramming:** Mermaid.js (ER Diagramming)

---

## 📁 Project Structure

```text
part3/
├── app/
│   ├── api/
│   │   ├── __init__.py
│   │   └── v1/
│   │       ├── __init__.py
│   │       ├── amenities.py
│   │       ├── auth.py
│   │       ├── places.py
│   │       ├── reviews.py
│   │       └── users.py
│   ├── models/
│   │   ├── __init__.py
│   │   ├── amenity.py
│   │   ├── base.py
│   │   ├── place.py
│   │   ├── review.py
│   │   └── user.py
│   ├── persistence/
│   │   ├── __init__.py
│   │   └── repository.py
│   ├── services/
│   │   ├── __init__.py
│   │   └── facade.py
│   ├── __init__.py
│   └── extensions.py
├── er_diagram.md
├── hbnb_er_diagram.md
├── schema.sql
├── seed.sql
├── config.py
├── run.py
└── README.md

🏗️ Architecture & Data Flow
Part 3 implements a layered architecture to decouple API routing, business logic, and database persistence:

API Layer (Flask-RESTx)
        │
        ▼
Facade Layer (Business Logic & Orchestration)
        │
        ▼
Repository Layer (SQLAlchemy ORM Data Access)
        │
        ▼
SQLite Database (development.db)



API Layer: Receives HTTP requests, validates input, checks authentication and authorization, and returns JSON responses.

Facade Layer: Coordinates operations between the API layer and the repositories.

Repository Layer: Handles database CRUD operations, attribute lookups, and relationship-specific queries.

Model Layer: SQLAlchemy models defining database entities and their relationships.



🗄️ Core Entities & Database Schema
The relational database architecture models connections between users, places, reviews, and amenities:

User: ID, First name, Last name, Email, Hashed password, Administrator status (is_admin), Creation & Update timestamps. (A user may own multiple places and write multiple reviews).

Place: ID, Title, Description, Price, Latitude, Longitude, Owner, Amenities, Reviews, Creation & Update timestamps.

Review: ID, Text, Author, Place, Creation & Update timestamps. (A user may submit only one review for the same place).

Amenity: ID, Name, Creation & Update timestamps. (Places and amenities have a many-to-many relationship).


⚙️ Getting Started & Installation
1. Clone the Repository

git clone [https://github.com/holbertonschool-hbnb.git](https://github.com/holbertonschool-hbnb.git)
cd holbertonschool-hbnb/part3


2. Install Dependencies
We recommend using a virtual environment:

python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

3. Set Up the Database
Initialize the SQLite database schema and insert seed data:

sqlite3 instance/development.db < schema.sql
sqlite3 instance/development.db < seed.sql
(Note: For MySQL production environments, use mysql -h hostname -u user database < schema.sql)

🔧 Configuration
Configure environment parameters and security settings in config.py:

# JWT Settings
JWT_SECRET_KEY = 'your-secret-key'
JWT_ACCESS_TOKEN_EXPIRES = 3600  # 1 hour

# Application settings
DEBUG = True

🚀 Usage & API Authentication
Run the Application

python run.py

Access the Swagger UI documentation at: http://localhost:5000/api/v1/

API Authentication (JWT)
Some endpoints require JWT authentication.



1.  Retrieve a token via login:

curl -X POST http://localhost:5000/api/v1/auth/login \
    -H "Content-Type: application/json" \
    -d '{"email": "user@example.com", "password": "password123"}'

2.  Use the token to access protected endpoints:

curl -X GET http://localhost:5000/api/v1/places \
    -H "Authorization: Bearer your_access_token"

🧪 Testing
The project includes unit tests to validate core functionalities:

python -m unittest discover tests

Tests cover:

Resource creation (success and validation errors)

Resource retrieval (existing and non-existing entities)

Resource updating and deletion

JWT Authentication and Role-based authorization


🧑‍💻 Authors
Bayadir Aldossari

Reem Alanazi

Shomokh Aldosari


📚 References
Flask Documentation

Flask-RESTx Docs

Flask-JWT-Extended Documentation

SQLAlchemy Documentation

Mermaid.js Documentation
