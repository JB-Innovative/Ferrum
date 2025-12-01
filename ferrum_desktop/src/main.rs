#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]
extern crate ferrum_core;
extern crate tauri;
use ferrum_core::BrowserCore;
use ferrum_core::get_dummy_render_buffer;

// 1. Definition des Tauri Command
#[tauri::command]
fn get_current_frame() -> Vec<u8> {
    get_dummy_render_buffer()
}

fn main() {
    let db_path = "ferrum.db";

    // 2. Core-Logik initialisieren (Datenbank)
    match BrowserCore::new(db_path) {
        Ok(_) => println!("Datenbank '{}' erfolgreich initialisiert und geprüft.", db_path),
        Err(e) => {
            eprintln!("FATAL ERROR: {}", e);
            std::process::exit(1);
        }
    }

    // 3. Tauri App starten
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![get_current_frame])
        .run(tauri::generate_context!())
        .expect("Fehler beim Starten der Tauri-Anwendung");
}