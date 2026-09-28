# CtrlAltDeliver

A full-stack e-commerce web application developed as a coursework project for managing products, customers, shopping carts, orders, payments, and shipments.

## Overview

**CtrlAltDeliver** is an e-commerce platform designed around a computer hardware and electronics store. The application provides separate functionality for customers and administrators, including product browsing, cart management, order processing, payment records, and shipment tracking.

The project demonstrates the development of a database-driven Java web application using MVC-oriented architecture, server-side processing, JSP, and MySQL/MariaDB.

## Features

### Customer

* User registration and login
* Secure password hashing using BCrypt
* Browse products by category
* Product details and product images
* Shopping cart management
* Add, update, and remove cart items
* Place orders
* View order history
* View order and payment status
* Track shipment status
* Manage profile information

### Administrator

* Administrator authentication
* Product management
* Category management
* Inventory/stock management
* Order management
* Payment status management
* Shipment and tracking management
* Customer/user management

## Technology Stack

| Technology      | Usage                                  |
| --------------- | -------------------------------------- |
| Java            | Application development                |
| Maven           | Dependency and project management      |
| JSP             | Server-side views                      |
| Servlets        | Request handling and application logic |
| MySQL / MariaDB | Database                               |
| HTML5           | Page structure                         |
| CSS3            | Styling                                |
| JavaScript      | Client-side functionality              |
| BCrypt          | Password hashing                       |
| Apache Tomcat   | Web application server                 |


## Database

The project includes a SQL database dump:

```text
ctrl_alt_deliver (3).sql
```

### Database Setup

1. Install **MySQL or MariaDB**.
2. Create a database named:

```sql
CREATE DATABASE ctrl_alt_deliver;
```

3. Import:

```text
ctrl_alt_deliver (3).sql
```

4. Configure the application's database connection with your local database credentials.
5. Build and run the project using Apache Tomcat.

> The SQL dump contains demonstration/seed data intended for development and coursework purposes.

## Demo Credentials

The included seed accounts use the same dummy password:

```text
Password: Demo@12345
```

Example accounts:

| Role          | Email                            |
| ------------- | -------------------------------- |
| Administrator | `alex.rivera@ctrlaltdeliver.com` |
| Member        | `nisha.karki@outlook.com`        |
| Member        | `falano.poudel@icp.edu.np`       |
| Member        | `example@gmail.com`              |

These credentials are for the included demonstration database only.

## Running the Project

### Prerequisites

Make sure the following are installed:

* JDK
* Apache Maven
* MySQL or MariaDB
* Apache Tomcat
* Git

### Clone the Repository

```bash
git clone https://github.com/pranish0-0/CtrlAltDeliver.git
cd CtrlAltDeliver
```

### Build the Project

```bash
mvn clean package
```

The generated WAR file will be available in:

```text
target/
```

Deploy the WAR file to Apache Tomcat and start the server.

## Configuration

Database connection settings should be configured for your local environment.

Do not commit real database passwords, API keys, authentication secrets, or other credentials to the repository.

## Security Note

This repository is a coursework project and contains demonstration data.

The included passwords are stored as BCrypt hashes rather than plaintext passwords. The accounts and associated data are intended only for local development and demonstration.

For a production deployment, additional security measures would be required, including:

* Environment-based secret management
* Strong password policies
* CSRF protection
* Input validation and sanitization
* Secure session management
* HTTPS
* Proper authorization controls
* Production database credentials and configuration

## Academic Project

This project was developed as part of an academic coursework project at **Informatics College Pokhara**.

The project focuses on applying software development concepts including:

* Object-oriented programming
* Java web development
* Database design
* CRUD operations
* Authentication and authorization
* MVC-oriented application structure
* E-commerce workflows
* Relational database relationships

## License

This project was created for academic and educational purposes.
