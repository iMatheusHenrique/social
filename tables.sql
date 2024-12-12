-- User (1:N) Event
-- Um usuário pode organizar vários eventos.

-- Event (1:N) Invite
-- Um evento pode ter vários convites enviados.

-- User (1:N) Invite
-- Um usuário pode receber vários convites.

-- Event (N:M) Category
-- Um evento pode pertencer a várias categorias, e cada categoria pode ser atribuída a vários eventos.

-- Event (1:N) GuestList
-- Um evento pode ter uma lista de convidados confirmados, incluindo informações adicionais como nome e foto.

-- Tabela User
CREATE TABLE User (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    nickname TEXT,
    email TEXT UNIQUE NOT NULL,
    phone TEXT NOT NULL,
    password_hash TEXT NOT NULL,
    profile_picture TEXT
);

-- Tabela Event
CREATE TABLE Event (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    start_time TIME NOT NULL,
    end_time TIME,
    location_map TEXT,
    city TEXT NOT NULL,
    state TEXT NOT NULL,
    organizer_id INTEGER NOT NULL,
    color_palette TEXT,
    FOREIGN KEY (organizer_id) REFERENCES User(id)
);

-- Tabela Invite
CREATE TABLE Invite (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    event_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    status TEXT CHECK (status IN ('accepted', 'denied', 'waiting')) NOT NULL,
    feedback TEXT,
    FOREIGN KEY (event_id) REFERENCES Event(id),
    FOREIGN KEY (user_id) REFERENCES User(id)
);

-- Tabela Category
CREATE TABLE Category (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

-- Tabela EventCategory (Relacionamento N:M)
CREATE TABLE EventCategory (
    event_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    PRIMARY KEY (event_id, category_id),
    FOREIGN KEY (event_id) REFERENCES Event(id),
    FOREIGN KEY (category_id) REFERENCES Category(id)
);

-- Tabela GuestList
CREATE TABLE GuestList (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    event_id INTEGER NOT NULL,
    guest_name TEXT NOT NULL,
    guest_photo TEXT,
    FOREIGN KEY (event_id) REFERENCES Event(id)
);
