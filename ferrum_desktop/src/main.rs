extern crate ferrum_core;
extern crate serde;
use ferrum_core::BrowserCore;
use ferrum_core::get_dummy_render_buffer; // Wichtig: Direkter Import der Funktion
use serde::Deserialize;

fn main() {
    // Der Pfad zur SQLite-Datei
    let db_path = "ferrum.db";

    // 2. Core-Logik initialisieren (Datenbank)
    match BrowserCore::new(db_path) {
        Ok(_) => println!("Datenbank '{}' erfolgreich initialisiert und geprüft.", db_path),
        Err(e) => {
            eprintln!("FATAL ERROR: Fehler beim Initialisieren der Datenbank: {}", e);
            std::process::exit(1);
        }
    }

    // 3. Tauri App starten
    tauri::Builder::default()
        // Registriert die Rust-Funktion als aufrufbaren Befehl
        //.invoke_handler(tauri::generate_handler![get_current_frame])

        // Startet die App. Das Makro findet jetzt die tauri.conf.json
        .run(tauri::generate_context!())
        .expect("Fehler beim Starten der Tauri-Anwendung");
}