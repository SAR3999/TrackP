from flask import Flask, render_template, request, redirect, url_for, flash
import mysql.connector
from mysql.connector import Error
from flask import session
app = Flask(__name__)
app.secret_key = 'your_secret_key'  # Replace with a strong secret key

# Database configuration
db_config = {
    'host': 'projectstore.vip',
    'database': 'imxrcwki_TrackP',
    'user': 'imxrcwki_TrackP',
    'password': 'HRHwZVUvL3TVUHy5SWMA'
}

# Database connection function
def get_db_connection():
    try:
        conn = mysql.connector.connect(**db_config)
        if conn.is_connected():
            return conn
    except Error as e:
        print(f"Database connection error: {e}")
        return None

@app.route('/home')
def home():
    conn = get_db_connection()
    total_stations = 0  # Default to 0 if there's an error
    if conn:
        cursor = conn.cursor()
        cursor.execute("SELECT COUNT(*) FROM Stations")
        total_stations = cursor.fetchone()[0]
        cursor.close()
        conn.close()
    return render_template('home.html', total_stations=total_stations)


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']

        # Establish database connection
        conn = get_db_connection()

        if conn:
            cursor = conn.cursor(dictionary=True)
            cursor.execute("SELECT * FROM users WHERE email = %s", (email,))
            user = cursor.fetchone()

            if user and user['password'] == password:
                # Set user_type in the session
                session['user_type'] = user['user_type']
                flash('Login successful!', 'success')

                # Redirect based on user type
                if user['user_type'] == 'admin':
                    return redirect(url_for('home'))
                elif user['user_type'] == 'station':
                    return redirect(url_for('login'))
            else:
                flash('Login failed. Check your credentials.', 'danger')

            cursor.close()
            conn.close()
        else:
            flash('Database connection error.', 'danger')

    return render_template('login.html')

@app.route('/stations', methods=['GET', 'POST'])
def stations():
    if request.method == 'POST':
        # Get form data from the submitted form
        station_name = request.form['station_name']
        station_email = request.form['station_email']
        password = request.form['password']
        station_mobile_no = request.form['station_mobile_no']
        longitude = request.form['longitude']
        latitude = request.form['latitude']
        state = request.form['state']
        district = request.form['district']
        division = request.form['division']
        city = request.form['city']
        date = request.form['date']

        # Connect to the database
        conn = get_db_connection()
        if conn:
            try:
                cursor = conn.cursor()

                # Insert station data into the Stations table
                insert_station_query = """
                INSERT INTO Stations (station_name, station_email, password, station_mobile_no, longitude, latitude, state, district, division, city, date)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                """
                cursor.execute(insert_station_query, (
                    station_name, station_email, password, station_mobile_no, longitude, latitude, state, district,
                    division, city, date
                ))

                # Insert station email and password into the users table with user_type='station'
                insert_user_query = """
                INSERT INTO users (email, password, user_type)
                VALUES (%s, %s, %s)
                """
                cursor.execute(insert_user_query, (station_email, password, 'station'))

                # Commit the transaction to save the changes
                conn.commit()
                flash('Station and user added successfully!', 'success')

            except Exception as e:
                conn.rollback()  # Rollback in case of an error
                flash(f'Error inserting data: {e}', 'danger')

            finally:
                cursor.close()
                conn.close()  # Close the cursor and the connection after use
        else:
            flash('Database connection error.', 'danger')

        return redirect(url_for('stations'))

    # For GET requests, fetch all stations from the database
    stations = []
    conn = get_db_connection()
    if conn:
        try:
            cursor = conn.cursor()
            cursor.execute("SELECT * FROM Stations")
            # Fetch all stations and map them to a list of dictionaries
            stations = [
                {
                    'station_name': row[1],
                    'station_email': row[2],
                    'station_mobile_no': row[4],
                    'longitude': row[5],
                    'latitude': row[6],
                    'state': row[7],
                    'district': row[8],
                    'division': row[9],
                    'city': row[10],
                    'date': row[11]
                }
                for row in cursor.fetchall()
            ]
        except Exception as e:
            flash(f'Error fetching stations: {e}', 'danger')
        finally:
            cursor.close()
            conn.close()

    # Render the page with the list of stations
    return render_template('stations.html', stations=stations)

if __name__ == '__main__':
    app.run(debug=True)
