use iced::{
    widget::{button, column, container, row, text, text_input},
    Length, Element, Theme, Subscription, Task, window, Alignment,
    Settings,
};
use url::Url;

// --- 1. Zustand der Anwendung (State-Typ) ---
#[derive(Default)]
pub struct FerrumBrowser {
    address_bar_text: String,
    current_url: String,
    is_loading: bool,
    error_message: Option<String>,
}

// --- 2. Mögliche Aktionen/Messages ---
#[derive(Debug, Clone)]
pub enum Message {
    AddressBarChanged(String),
    Navigate,
    GoBack,
    GoForward,
    PageLoaded(Result<String, String>),
}

// --- 3. Implementierung der Funktionalität (ersetzt Program-Trait) ---
impl FerrumBrowser {

    pub fn new() -> (Self, Task<Message>) {
        let state = FerrumBrowser {
            address_bar_text: String::from("https://www.google.de"),
            current_url: String::new(),
            is_loading: false,
            error_message: None,
            ..Default::default()
        };
        // Task::none ersetzt Command::none
        (state, Task::none())
    }

    // Entspricht Application::update (State ist nun &mut self)
    pub fn update(&mut self, message: Message) -> Task<Message> {
        match message {
            Message::AddressBarChanged(text) => {
                self.address_bar_text = text;
                Task::none()
            }
            Message::Navigate => {
                let url_string = self.address_bar_text.clone();

                // 1. Zustand aktualisieren: Laden beginnt
                self.current_url = url_string.clone();
                self.is_loading = true;

                log::info!("Navigiere zu: {}", url_string);

                // 2. Task starten: Asynchrone Funktion, die geladenen Inhalt zurückgibt
                let task = Task::perform(
                    load_page(url_string),
                    Message::PageLoaded // Mapped das Ergebnis des Tasks auf die Message::PageLoaded
                );

                task
            }
            Message::GoBack => {
                log::info!("Zurück-Button gedrückt.");
                Task::none()
            }
            Message::GoForward => {
                log::info!("Vorwärts-Button gedrückt.");
                Task::none()
            }
            Message::PageLoaded(result) => {
                // 1. Zustand aktualisieren: Laden beendet
                self.is_loading = false;

                match result {
                    Ok(html) => {
                        // Simuliere, dass wir den HTML-Inhalt anzeigen (aktuell nur als Log)
                        log::info!("Seite erfolgreich geladen ({} Bytes).", html.len());
                        self.error_message = None;
                        // Hier müssten wir später den Webview-Inhalt setzen
                    }
                    Err(e) => {
                        // Fehler anzeigen
                        log::error!("Ladefehler: {}", e);
                        self.error_message = Some(e);
                    }
                }
                Task::none()
            }
        }
    }

    // Entspricht Application::subscription
    pub fn subscription(&self) -> Subscription<Message> {
        Subscription::none()
    }

    // Entspricht Application::view (State ist nun &self)
    pub fn view(&self) -> Element<Message, Theme> {
        // KORREKTUR: Explizite Variable für den if/else-Block, um Typfehler zu vermeiden.
        let loading_status: Element<Message, Theme> = if self.is_loading {
            text("Lade...").into()
        } else {
            text("Bereit.").into()
        };

        // --- Navigation Bar ---
        let nav_bar = row![
            button("Zurück").on_press(Message::GoBack),
            button("Vorwärts").on_press(Message::GoForward),

            text_input(
                "Geben Sie eine URL ein...",
                &self.address_bar_text,
            )
            .on_input(Message::AddressBarChanged)
            .padding(10)
            .size(16)
            .width(Length::Fill),

            button("Laden").on_press(Message::Navigate)
        ]
            .spacing(5)
            .padding(10)
            .align_y(Alignment::Center);

        // --- Content Container (Platzhalter) ---

        let error_or_url_display: Element<Message, Theme> = if let Some(error) = &self.error_message {
            // Wenn Fehler vorhanden, rot anzeigen
            text(format!("FEHLER: {}", error))
                .size(20)
                .color([0.8, 0.2, 0.2])
                .into()
        } else {
            // Ansonsten aktuelle URL anzeigen
            text(format!("Aktuelle URL: {}", self.current_url)).size(20).into()
        };

        let loading_indicator: Element<Message, Theme> = if self.is_loading {
            text("Lade Inhalt...").into()
        } else {
            text("Web Content Platzhalter").into()
        };
        
        let content_area = container(
            column![
                // Verwende die explizit typisierte Variable
                error_or_url_display,
                loading_indicator,
            ]
                .spacing(15)
                .align_x(Alignment::Center)
        )
            .width(Length::Fill)
            .height(Length::Fill)
            .center_x(Length::Fill)
            .center_y(Length::Fill);

        column![nav_bar, content_area].into()
    }

}

// Asynchrone Funktion, die den HTTP-Request durchführt
async fn load_page(url_string: String) -> Result<String, String> {
    // Überprüfe und normalisiere die URL
    let url = match Url::parse(&url_string) {
        Ok(url) => url,
        Err(_) => return Err(format!("Ungültige URL: {}", url_string)),
    };

    // Führe den HTTP-Request durch
    let response = reqwest::get(url)
        .await
        .map_err(|e| format!("Fehler beim Senden der Anfrage: {}", e))?;

    // Überprüfe den Statuscode
    if !response.status().is_success() {
        return Err(format!("HTTP Fehler: Status {}", response.status()));
    }

    // Lese den Body (HTML-Inhalt)
    response
        .text()
        .await
        .map_err(|e| format!("Fehler beim Lesen des Inhalts: {}", e))
}