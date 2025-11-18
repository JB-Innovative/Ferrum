use iced::{Settings};
use iced::window;
use iced::Application; // Application wird für den Fall benötigt, dass iced::application nicht existiert.

// Deklariere das UI-Modul
mod ui;
// Importiert das FerrumBrowser-Struct
use ui::gui::FerrumBrowser;

fn main() -> iced::Result {
    env_logger::init();
    log::info!("Starte Ferrum Browser...");

    // KORREKTUR: Verwende die idiomatische 'iced::application' Funktion (oder iced::program, falls sie umbenannt wurde)
    // zusammen mit den assoziierten Methoden des FerrumBrowser-Structs.

    // Fallback auf die funktionale Starter-API:
    // Wir übergeben new, update und view als Funktionszeiger.
    iced::application(FerrumBrowser::new, FerrumBrowser::update, FerrumBrowser::view)
        .subscription(FerrumBrowser::subscription) // Füge Subscription hinzu
        .run()
}