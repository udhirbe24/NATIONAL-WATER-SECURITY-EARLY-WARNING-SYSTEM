# System Design & Architecture
## National Water Security & Early Warning System

### 1. Problem Statement
India faces significant challenges in managing its water resources across various distinct climate zones. Frequent flooding, prolonged droughts, and increasing contamination of reservoirs pose severe threats to national water security. 

Currently, field data regarding rainfall, groundwater depth, and water quality is often siloed, making it difficult for regional officers and central authorities to coordinate rapidly. There is a critical need for a centralized, dynamic tracking system that can monitor these metrics in real-time and **automatically issue early warnings** for potential crises before they escalate.

### 2. Full System Architecture
The application is built on a decoupled, three-tier architecture ensuring stability, security, and a modular development workflow:

- **Frontend (Presentation Layer)**:
  - Built with Vanilla HTML5, CSS3, and JavaScript to maintain a lightweight footprint without the overhead of heavy frameworks.
  - Follows a stark "Swiss Minimalist" design aesthetic emphasizing readability, high contrast, and structured grid layouts.
  - State management is handled completely client-side using zero-reload Single Page Application (SPA) techniques and HTML5 `sessionStorage`.
  - Data visualization is driven by **Chart.js**, rendering dynamic trends for rainfall and reservoir capacities.

- **Backend (Logic Layer)**:
  - Developed in **Python** using the **Flask** micro-framework.
  - Provides RESTful JSON APIs (`/api/login`, `/api/register`, `/api/reservoirs`, `/api/alerts`, etc.) for the frontend to consume via the Fetch API.
  - Uses the modern `oracledb` (Thin mode) driver, removing the need for complex Oracle client installations.

- **Database (Data Layer)**:
  - Powered by **Oracle Database (11g/XE/18c)**.
  - Highly normalized schema containing 9 relational tables (Regions, Officers, Users, Reservoirs, Rivers, Rainfall, Groundwater, Water Quality, and Alerts).
  - Employs **PL/SQL Triggers** to automatically generate alerts (e.g., if a new water quality record is inserted with a pH > 8.5, an automatic 'Contamination' alert is generated for that region).

### 3. Login & Authentication Flow
The system utilizes a lightweight Role-Based Access Control (RBAC) mechanism.

#### Registration Flow:
1. A new user selects "Register" and inputs a `username`, `password`, and selects a `role` (`Admin`, `ResourceOfficer`, `MonitoringAuthority`).
2. The frontend sends a `POST` request to `/api/register`.
3. The Flask backend verifies the username is unique and inserts the record into the `login_user` table using an Oracle Sequence (`seq_login_user.NEXTVAL`).
4. Since the user is new, they are not yet bound to a specific `officer_id` (this acts as a dynamic loose coupling).

#### Login Flow:
1. The user inputs their credentials and submits the form.
2. The frontend sends a `POST` request to `/api/login`.
3. The backend executes a `LEFT JOIN` query:
   ```sql
   SELECT l.username, l.password, l.role, o.officer_name 
   FROM login_user l 
   LEFT JOIN officer o ON l.officer_id = o.officer_id 
   WHERE l.username = :1 AND l.password = :2
   ```
   *Note: The LEFT JOIN ensures that dynamically registered users (who do not have an `officer_id`) can still log in successfully.*
4. Upon successful validation, the backend returns the user's `role` and `officer_name` (or "New User").
5. The frontend stores this data in `sessionStorage` and redirects the browser to the appropriate portal:
   - `Admin` → `/admin`
   - `ResourceOfficer` → `/officer`
   - `MonitoringAuthority` → `/monitor`
6. Protected pages immediately check `sessionStorage` on load. If the role is missing or incorrect, they instantly boot the user back to the login page.
