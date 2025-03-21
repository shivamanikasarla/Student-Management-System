from flask import Flask, request, jsonify
from flask_mysqldb import MySQL
import db_config

app = Flask(__name__)

# MySQL Config
app.config['MYSQL_HOST'] = db_config.MYSQL_HOST
app.config['MYSQL_USER'] = db_config.MYSQL_USER
app.config['MYSQL_PASSWORD'] = db_config.MYSQL_PASSWORD
app.config['MYSQL_DB'] = db_config.MYSQL_DB

mysql = MySQL(app)

# Route to test the server
@app.route('/')
def home():
    return "Student Management System Backend is Running!"

# Route to add a student
@app.route('/add_student', methods=['POST'])
def add_student():
    data = request.get_json()

    name = data.get('name')
    age = data.get('age')
    gender = data.get('gender')
    dob = data.get('dob')
    contact = data.get('contact')
    department_id = data.get('department_id')

    if not all([name, age, gender, dob, contact, department_id]):
        return jsonify({"message": "Missing data"}), 400

    cur = mysql.connection.cursor()

    try:
        cur.execute("""
            INSERT INTO Students (Name, Age, Gender, DOB, Contact, DepartmentID)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (name, age, gender, dob, contact, department_id))

        mysql.connection.commit()
        return jsonify({"message": "Student added successfully"}), 201

    except Exception as e:
        mysql.connection.rollback()
        return jsonify({"message": str(e)}), 500

    finally:
        cur.close()

# Route to get all students
@app.route('/students', methods=['GET'])
def get_students():
    cur = mysql.connection.cursor()
    try:
        cur.execute("SELECT * FROM Students")
        rows = cur.fetchall()

        students = []
        for row in rows:
            student = {
                'StudentID': row[0],
                'Name': row[1],
                'Age': row[2],
                'Gender': row[3],
                'DOB': row[4].strftime('%Y-%m-%d'),
                'Contact': row[5],
                'DepartmentID': row[6]
            }
            students.append(student)

        return jsonify(students)

    except Exception as e:
        return jsonify({"message": str(e)}), 500

    finally:
        cur.close()

if __name__ == '__main__':
    app.run(debug=True)
