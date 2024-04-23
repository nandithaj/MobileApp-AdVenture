from flask import Flask, request, jsonify
import psycopg2

app = Flask(__name__)

def get_db_connection():
    conn = psycopg2.connect(
        database="miniproj",
        user="postgres",
        host='localhost',
        password="123456",
        port=5432
    )
    return conn

@app.route('/login', methods=['POST'])
def login_user():
    # Get user data from the request body (assuming JSON format)
    data = request.get_json()

    username = data.get('username')
    password = data.get('password')

    # Validate input data (optional)

    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        # Check if username exists
        cursor.execute("""
            SELECT id FROM users WHERE username = %s
        """, (username,))
        user_id = cursor.fetchone()

        if user_id:  # User found
            # Validate password (replace with your password hashing logic)
            # Assuming password is stored at index 2
            cursor.execute("""
                SELECT id FROM users WHERE username = %s AND password = %s
            """, (username, password))
            user_id = cursor.fetchone()

            if user_id:
                return jsonify({'message': 'Login successful!', 'user_id': user_id}), 200
            else:
                return jsonify({'message': 'Invalid password'}), 401  # Unauthorized
        else:
            return jsonify({'message': 'Username not found'}), 404  # Not Found

    except (Exception, psycopg2.Error) as error:
        print("Error while logging in:", error)
        return jsonify({'message': 'Login failed!'}), 400  # Bad Request
    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()
@app.route('/screens', methods=['GET'])
def get_screens():
    try:
        owner_id = request.args.get('owner_id')
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT screen_name FROM screens WHERE owner_id = %s", (owner_id,))
        screen_names = cursor.fetchall()
        cursor.close()
        conn.close()
        screen_names = [name[0] for name in screen_names]  # Extract screen names from tuples
        return jsonify({'screen_names': screen_names}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

print(f"Service listening on: http://localhost:{5000}")

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
