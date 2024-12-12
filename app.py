import sqlite3

connection = sqlite3.connect('social.db')
cursor = connection.cursor()

sql_commands = [
    """
    CREATE TABLE IF NOT EXISTS User (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        nickname TEXT,
        email TEXT UNIQUE NOT NULL,
        phone TEXT NOT NULL,
        password_hash TEXT NOT NULL,
        profile_picture TEXT,
        latitude REAL,
        longitude REAL
    );
    """,
    """
    CREATE TABLE IF NOT EXISTS State (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        code TEXT NOT NULL UNIQUE
    );
    """,

    """
    CREATE TABLE IF NOT EXISTS City (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        state_id INTEGER NOT NULL,
        FOREIGN KEY (state_id) REFERENCES State(id)
    );
    """,
    """
    CREATE TABLE IF NOT EXISTS Event (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        start_date DATE NOT NULL,
        end_date DATE, 
        start_time TIME NOT NULL,
        end_time TIME,
        location_map TEXT,
        city_id INTEGER NOT NULL,
        organizer_id INTEGER NOT NULL,
        color_palette TEXT,
        latitude REAL,
        longitude REAL,
        FOREIGN KEY (city_id) REFERENCES City(id),
        FOREIGN KEY (organizer_id) REFERENCES User(id)
    );
    """,

    """
    CREATE TABLE IF NOT EXISTS Invite (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        event_id INTEGER NOT NULL,
        user_id INTEGER NOT NULL,
        status TEXT CHECK (status IN ('accepted', 'denied', 'waiting')) NOT NULL,
        feedback TEXT,
        FOREIGN KEY (event_id) REFERENCES Event(id),
        FOREIGN KEY (user_id) REFERENCES User(id)
    );
    """,
    """
    CREATE TABLE IF NOT EXISTS Category (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
    );
    """,
    """
    CREATE TABLE IF NOT EXISTS EventCategory (
        event_id INTEGER NOT NULL,
        category_id INTEGER NOT NULL,
        PRIMARY KEY (event_id, category_id),
        FOREIGN KEY (event_id) REFERENCES Event(id),
        FOREIGN KEY (category_id) REFERENCES Category(id)
    );
    """,
    """
    CREATE TABLE IF NOT EXISTS GuestList (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        event_id INTEGER NOT NULL,
        guest_name TEXT NOT NULL,
        guest_photo TEXT,
        FOREIGN KEY (event_id) REFERENCES Event(id)
    );
    """
]

for command in sql_commands:
    cursor.execute(command)

connection.commit()
connection.close()
