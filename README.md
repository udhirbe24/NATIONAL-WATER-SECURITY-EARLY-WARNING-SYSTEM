# National Water Security & Early Warning System (NWSEWS)

A complete, production-quality database management system project designed for course UCS310 at Thapar Institute of Engineering and Technology. The system monitors water regions, tracks reservoirs, logs rainfall and groundwater levels, evaluates water quality, and automatically generates alerts for flooding, droughts, and contamination.

## 🛠️ Technology Stack
- **Database:** Oracle Database (XE) + PL/SQL (Triggers, Procedures, Functions, Cursors)
- **Backend:** Python (Flask), `oracledb`
- **Frontend:** HTML5, CSS3 (Vanilla), JavaScript, Chart.js

## 📂 Project Structure
```text
project/
├── app.py                      # Main Flask Backend application
├── requirements.txt            # Python dependencies
├── README.md                   # Project documentation
├── database/                   # Oracle SQL/PL/SQL scripts
│   ├── 01_drop.sql
│   ├── 02_create_tables.sql
│   ├── 03_insert_data.sql
│   ├── 04_triggers.sql
│   ├── 05_procedures.sql
│   ├── 06_functions.sql
│   └── 07_cursors.sql
├── static/                     # Frontend Assets
│   ├── css/
│   │   └── style.css           # Global stylesheet
│   └── js/
│       ├── admin.js            # Admin dashboard logic
│       ├── login.js            # Authentication logic
│       ├── monitor.js          # Chart rendering and filtering logic
│       └── officer.js          # Field data entry logic
└── templates/                  # HTML Views
    ├── admin.html
    ├── login.html
    ├── monitor.html
    └── officer.html
```

## 🚀 Setup Instructions

### 1. Database Setup
Ensure you have Oracle Database (e.g., Oracle 11g/18c/21c XE) installed and running locally.
Open Oracle SQL Developer and execute the scripts located in the `database/` folder **in the exact following order**:
1. `01_drop.sql` *(Safely cleans up any existing objects)*
2. `02_create_tables.sql` *(Creates all tables and sequences in FK-safe order)*
3. `03_insert_data.sql` *(Populates realistic dummy data)*
4. `04_triggers.sql` *(Adds alert automation logic for contamination & floods)*
5. `05_procedures.sql` *(Adds analytical procedures)*
6. `06_functions.sql` *(Adds aggregation functions)*
7. `07_cursors.sql` *(Adds alert reporting cursors)*

### 2. Backend Setup
1. Open `app.py` in your code editor.
2. Update line 10 to include your actual Oracle Database password for the `system` user:
   ```python
   DB_PASSWORD = "your_actual_password"
   ```
3. Open a terminal in the `project/` directory and create a virtual environment:
   ```bash
   # Windows
   python -m venv venv
   venv\Scripts\activate

   # macOS/Linux
   python3 -m venv venv
   source venv/bin/activate
   ```
4. Install the required Python dependencies:
   ```bash
   pip install -r requirements.txt
   ```
5. Start the Flask server:
   ```bash
   python app.py
   ```
6. Open your web browser and navigate to `http://localhost:5000`.

## 🔐 Sample Credentials
The system uses role-based access control (RBAC). Use these credentials to test the different views:

| Role | Username | Password | Access |
|------|----------|----------|--------|
| **User** | `user1` | `user123` | Can view overall system health and resolve alerts |
| **Resource Officer** | `officer1` | `off123` | Can input field data (Rainfall, pH, Turbidity, etc.) |
| **Monitoring Authority** | `monitor1` | `mon123` | Can view real-time Chart.js dashboards and trends |
