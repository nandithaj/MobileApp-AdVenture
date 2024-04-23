import psycopg2
//TO INSERT AN IMAGE INTO POSTGRESQL
# Database connection details (replace with your own)
DATABASE_NAME = "miniproj"
DATABASE_USER = "postgres"
DATABASE_PASSWORD = "123456"

# Image path (assuming it's in the assets folder)
IMAGE_PATH = "C:\\adventure\\mobileapp\\assets\\burgerking.png"


def insert_image_to_database():
  try:
    # Connect to PostgreSQL database
    conn = psycopg2.connect(database="miniproj",
        user="postgres",
        host='localhost',
        password="123456",
        port=5432)
    cur = conn.cursor()

    # Read image data
    with open(IMAGE_PATH, "rb") as f:
      image_data = f.read()

    # Convert to psycopg2 binary format
    image_data_for_db = psycopg2.Binary(image_data)

    # Insert image data (replace with your table structure)
    cur.execute("INSERT INTO ads (ad_id, ad_content) VALUES (%s, %s)", (1, image_data_for_db))
    conn.commit()

    print("Image inserted successfully!")

  except Exception as e:
    print("Error inserting image:", e)
  finally:
    # Close connection (important)
    if conn:
      cur.close()
      conn.close()

if __name__ == "__main__":
  insert_image_to_database()
