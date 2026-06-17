import oracledb
from flask import Flask, request, jsonify, render_template
from flask_cors import CORS
from datetime import datetime

app = Flask(__name__)
CORS(app)

DB_USER = "system"
DB_PASSWORD = "uday123456"
DB_DSN = "localhost/XE"

def get_connection():
    return oracledb.connect(user=DB_USER, password=DB_PASSWORD, dsn=DB_DSN)

def get_cursor(conn):
    return conn.cursor()

def rows_to_dicts(cursor):
    columns = [col[0].lower() for col in cursor.description]
    results = []
    for row in cursor.fetchall():
        row_dict = dict(zip(columns, row))
        for key, val in row_dict.items():
            if isinstance(val, datetime):
                if val.hour == 0 and val.minute == 0 and val.second == 0:
                    row_dict[key] = val.strftime('%Y-%m-%d')
                else:
                    row_dict[key] = str(val)
        results.append(row_dict)
    return results

@app.route('/')
def index():
    return render_template('login.html')

@app.route('/user')
def user_page():
    return render_template('user.html')

@app.route('/officer')
def officer_page():
    return render_template('officer.html')

@app.route('/monitor')
def monitor_page():
    return render_template('monitor.html')

@app.route('/api/regions', methods=['GET'])
def api_regions():
    try:
        conn = get_connection()
        cur = get_cursor(conn)
        cur.execute("SELECT region_id, region_name, state, population, climate_type FROM water_region")
        data = rows_to_dicts(cur)
        return jsonify(data)
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if 'conn' in locals(): conn.close()

@app.route('/api/dashboard/stats', methods=['GET'])
def dashboard_stats():
    try:
        conn = get_connection()
        cur = get_cursor(conn)
        cur.execute("SELECT COUNT(*) FROM water_region")
        total_regions = cur.fetchone()[0]
        cur.execute("SELECT COUNT(*) FROM reservoir")
        total_reservoirs = cur.fetchone()[0]
        cur.execute("SELECT COUNT(*) FROM alert WHERE is_resolved='N'")
        total_alerts = cur.fetchone()[0]
        cur.execute("SELECT COUNT(*) FROM alert WHERE is_resolved='N' AND alert_level='Critical'")
        critical_alerts = cur.fetchone()[0]
        return jsonify({
            "total_regions": total_regions,
            "total_reservoirs": total_reservoirs,
            "total_active_alerts": total_alerts,
            "critical_alert_count": critical_alerts
        })
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if 'conn' in locals(): conn.close()

@app.route('/api/alerts', methods=['GET'])
def get_alerts():
    try:
        conn = get_connection()
        cur = get_cursor(conn)
        cur.execute("""
            SELECT a.alert_id, a.alert_type, a.alert_level, a.alert_timestamp, a.is_resolved, w.region_name 
            FROM alert a 
            JOIN water_region w ON a.region_id = w.region_id 
            ORDER BY a.alert_timestamp DESC
        """)
        return jsonify(rows_to_dicts(cur))
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if 'conn' in locals(): conn.close()

@app.route('/api/alerts/<int:region_id>', methods=['GET'])
def get_alerts_by_region(region_id):
    try:
        conn = get_connection()
        cur = get_cursor(conn)
        cur.execute("""
            SELECT a.alert_id, a.alert_type, a.alert_level, a.alert_timestamp, a.is_resolved, w.region_name 
            FROM alert a 
            JOIN water_region w ON a.region_id = w.region_id 
            WHERE a.region_id = :1
            ORDER BY a.alert_timestamp DESC
        """, [region_id])
        return jsonify(rows_to_dicts(cur))
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if 'conn' in locals(): conn.close()

@app.route('/api/alerts/resolve/<int:alert_id>', methods=['POST'])
def resolve_alert(alert_id):
    data = request.json
    try:
        conn = get_connection()
        cur = get_cursor(conn)
        cur.execute("UPDATE alert SET is_resolved='Y', resolved_by=:1 WHERE alert_id = :2", [data.get('username'), alert_id])
        conn.commit()
        return jsonify({"success": True})
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if 'conn' in locals(): conn.close()

@app.route('/api/reservoirs', methods=['GET'])
def get_reservoirs():
    try:
        conn = get_connection()
        cur = get_cursor(conn)
        cur.execute("""
            SELECT r.reservoir_id, r.reservoir_name, r.capacity, r.current_level, w.region_name, 
            ROUND((r.current_level / r.capacity) * 100, 2) AS fill_percentage 
            FROM reservoir r 
            JOIN water_region w ON r.region_id = w.region_id
        """)
        return jsonify(rows_to_dicts(cur))
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if 'conn' in locals(): conn.close()

@app.route('/api/rivers', methods=['GET'])
def get_rivers():
    try:
        conn = get_connection()
        cur = get_cursor(conn)
        cur.execute("""
            SELECT r.river_id, r.river_name, r.flow_rate, r.water_level, w.region_name 
            FROM river r 
            JOIN water_region w ON r.region_id = w.region_id
        """)
        return jsonify(rows_to_dicts(cur))
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if 'conn' in locals(): conn.close()

@app.route('/api/rainfall/<int:region_id>', methods=['GET'])
def get_rainfall(region_id):
    try:
        conn = get_connection()
        cur = get_cursor(conn)
        cur.execute("""
            SELECT record_date, rainfall_amount 
            FROM (
                SELECT record_date, rainfall_amount 
                FROM rainfall_record 
                WHERE region_id = :1 
                ORDER BY record_date DESC
            ) WHERE ROWNUM <= 10
        """, [region_id])
        data = []
        columns = [col[0].lower() for col in cur.description]
        for row in cur.fetchall():
            row_dict = dict(zip(columns, row))
            if isinstance(row_dict['record_date'], datetime):
                row_dict['record_date'] = row_dict['record_date'].strftime('%Y-%m-%d')
            data.append(row_dict)
        return jsonify(data)
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if 'conn' in locals(): conn.close()

@app.route('/api/groundwater/<int:region_id>', methods=['GET'])
def get_groundwater(region_id):
    try:
        conn = get_connection()
        cur = get_cursor(conn)
        cur.execute("""
            SELECT record_date, depth 
            FROM (
                SELECT record_date, depth 
                FROM groundwater_record 
                WHERE region_id = :1 
                ORDER BY record_date DESC
            ) WHERE ROWNUM <= 10
        """, [region_id])
        data = []
        columns = [col[0].lower() for col in cur.description]
        for row in cur.fetchall():
            row_dict = dict(zip(columns, row))
            if isinstance(row_dict['record_date'], datetime):
                row_dict['record_date'] = row_dict['record_date'].strftime('%Y-%m-%d')
            data.append(row_dict)
        return jsonify(data)
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if 'conn' in locals(): conn.close()

@app.route('/api/water-quality', methods=['GET'])
def get_water_quality_records():
    try:
        conn = get_connection()
        cur = get_cursor(conn)
        cur.execute("""
            SELECT wq.quality_id, wq.ph_level, wq.turbidity, r.reservoir_name, w.region_name 
            FROM water_quality wq 
            JOIN reservoir r ON wq.reservoir_id = r.reservoir_id 
            JOIN water_region w ON r.region_id = w.region_id
        """)
        return jsonify(rows_to_dicts(cur))
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if 'conn' in locals(): conn.close()

@app.route('/api/water-quality', methods=['POST'])
def add_water_quality():
    data = request.json
    try:
        conn = get_connection()
        cur = get_cursor(conn)
        cur.execute("""
            INSERT INTO water_quality (quality_id, ph_level, turbidity, reservoir_id, inserted_by) 
            VALUES (seq_water_quality.NEXTVAL, :1, :2, :3, :4)
        """, [data['ph_level'], data['turbidity'], data['reservoir_id'], data.get('username')])
        conn.commit()
        return jsonify({"success": True})
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if 'conn' in locals(): conn.close()

@app.route('/api/rainfall', methods=['POST'])
def add_rainfall():
    data = request.json
    try:
        conn = get_connection()
        cur = get_cursor(conn)
        date_obj = datetime.strptime(data['record_date'], '%Y-%m-%d')
        cur.execute("""
            INSERT INTO rainfall_record (rainfall_id, record_date, rainfall_amount, region_id, inserted_by) 
            VALUES (seq_rainfall.NEXTVAL, :1, :2, :3, :4)
        """, [date_obj, data['rainfall_amount'], data['region_id'], data.get('username')])
        conn.commit()
        return jsonify({"success": True})
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if 'conn' in locals(): conn.close()

@app.route('/api/groundwater', methods=['POST'])
def add_groundwater():
    data = request.json
    try:
        conn = get_connection()
        cur = get_cursor(conn)
        date_obj = datetime.strptime(data['record_date'], '%Y-%m-%d')
        cur.execute("""
            INSERT INTO groundwater_record (groundwater_id, record_date, depth, region_id, inserted_by) 
            VALUES (seq_groundwater.NEXTVAL, :1, :2, :3, :4)
        """, [date_obj, data['depth'], data['region_id'], data.get('username')])
        conn.commit()
        return jsonify({"success": True})
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if 'conn' in locals(): conn.close()

@app.route('/api/reservoir', methods=['POST'])
def add_reservoir():
    data = request.json
    try:
        conn = get_connection()
        cur = get_cursor(conn)
        cur.execute("""
            INSERT INTO reservoir (reservoir_id, reservoir_name, capacity, current_level, region_id) 
            VALUES (seq_reservoir.NEXTVAL, :1, :2, :3, :4)
        """, [data['reservoir_name'], data['capacity'], data['current_level'], data['region_id']])
        conn.commit()
        return jsonify({"success": True})
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if 'conn' in locals(): conn.close()

@app.route('/api/login', methods=['POST'])
def login():
    data = request.json
    try:
        conn = get_connection()
        cur = get_cursor(conn)
        cur.execute("""
            SELECT l.username, l.password, l.role, o.officer_name 
            FROM login_user l 
            LEFT JOIN officer o ON l.officer_id = o.officer_id 
            WHERE l.username = :1 AND l.password = :2
        """, [data['username'], data['password']])
        user = cur.fetchone()
        if user:
            return jsonify({"success": True, "role": user[2], "officer_name": user[3] or user[0]})
        return jsonify({"success": False, "message": "Invalid credentials"})
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if 'conn' in locals(): conn.close()

@app.route('/api/register', methods=['POST'])
def register():
    data = request.json
    try:
        conn = get_connection()
        cur = get_cursor(conn)
        
        # Check if username exists
        cur.execute("SELECT COUNT(*) FROM login_user WHERE username = :1", [data['username']])
        if cur.fetchone()[0] > 0:
            return jsonify({"success": False, "message": "Username already exists"})
            
        cur.execute("""
            INSERT INTO login_user (user_id, username, password, role) 
            VALUES (seq_login_user.NEXTVAL, :1, :2, :3)
        """, [data['username'], data['password'], data['role']])
        conn.commit()
        return jsonify({"success": True})
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if 'conn' in locals(): conn.close()

@app.route('/api/profile/<role>/<username>', methods=['GET'])
def get_profile_stats(role, username):
    try:
        conn = get_connection()
        cur = get_cursor(conn)
        count = 0
        if role == 'User':
            cur.execute("SELECT COUNT(*) FROM alert WHERE resolved_by = :1", [username])
            count = cur.fetchone()[0]
        elif role == 'ResourceOfficer':
            cur.execute("""
                SELECT 
                  (SELECT COUNT(*) FROM rainfall_record WHERE inserted_by = :1) +
                  (SELECT COUNT(*) FROM groundwater_record WHERE inserted_by = :1) +
                  (SELECT COUNT(*) FROM water_quality WHERE inserted_by = :1)
                FROM DUAL
            """, [username])
            count = cur.fetchone()[0]
            
        return jsonify({"success": True, "count": count})
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if 'conn' in locals(): conn.close()

if __name__ == '__main__':
    app.run(debug=True, port=5000)
