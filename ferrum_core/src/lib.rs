use rusqlite::{Connection, Result};
#[allow(dead_code)]
pub struct BrowserCore {
    // Die Datenbankverbindung, die später für alle DB-Operationen genutzt wird.
    db_conn: Connection,
}

impl BrowserCore {
    /// Initialisiert die Core-Logik und die SQLite-Datenbank.
    pub fn new(db_path: &str) -> Result<Self> {
        // Stellt die Verbindung zur SQLite-Datenbank her.
        let conn = Connection::open(db_path)?;

        // Initialisiert die Tabellen (Lesezeichen, Verlauf, Einstellungen).
        Self::init_db(&conn)?;

        Ok(BrowserCore { db_conn: conn })
    }

    /// Erstellt die benötigten Datenbank-Tabellen, falls sie noch nicht existieren.
    fn init_db(conn: &Connection) -> Result<()> {
        conn.execute(
            "CREATE TABLE IF NOT EXISTS bookmarks (
                id INTEGER PRIMARY KEY,
                url TEXT NOT NULL UNIQUE,
                title TEXT,
                date_added INTEGER
            )",
            [],
        )?;
        conn.execute(
            "CREATE TABLE IF NOT EXISTS history (
                id INTEGER PRIMARY KEY,
                url TEXT NOT NULL,
                title TEXT,
                visit_time INTEGER
            )",
            [],
        )?;
        conn.execute(
            "CREATE TABLE IF NOT EXISTS user_prefs (
                key TEXT PRIMARY KEY,
                value TEXT
            )",
            [],
        )?;
        Ok(())
    }

    // TODO: Hier kommen später Methoden für Lesezeichen speichern, Verlauf abrufen etc.
}

/// Platzhalter für den Rendering-Output des Servo-Engines.
/// Gibt einen Pixel-Puffer (Vec<u8>) zurück, den das Frontend zeichnet.
pub fn get_dummy_render_buffer() -> Vec<u8> {
    const WIDTH: usize = 640;
    const HEIGHT: usize = 480;
    const CHANNELS: usize = 3; // RGB
    let mut buffer = vec![0u8; WIDTH * HEIGHT * CHANNELS];

    for y in 0..HEIGHT {
        for x in 0..WIDTH {
            let index = (y * WIDTH + x) * CHANNELS;

            // Einfaches Checkerboard-Muster
            let (r, g, b) = if (x / 40) % 2 == (y / 40) % 2 {
                // Farbe 1: Hellblau
                (50, 50, 255)
            } else {
                // Farbe 2: Gelb
                (255, 255, 0)
            };

            buffer[index] = r;
            buffer[index + 1] = g;
            buffer[index + 2] = b;
        }
    }
    buffer
}