use iced::{
    widget::{button, column, container, row, text, text_input},
    Length, Element, Theme, Subscription, Task, window, Alignment,
    Settings,
};

// --- 1. Zustand der Anwendung (State-Typ) ---
// Das struct dient nun als State-Container.
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
    // Message für Iced::application, falls es Task/Command nicht unterstützt
    // Tick,
}

// --- 3. Implementierung der Funktionalität (ersetzt Program-Trait) ---
impl FerrumBrowser {
    // Entspricht Application::new
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
            }
            Message::Navigate => {
                log::info!("Navigiere zu: {}", self.address_bar_text);
                self.current_url = self.address_bar_text.clone();
                self.is_loading = true;
            }
            Message::GoBack => {
                log::info!("Zurück-Button gedrückt.");
            }
            Message::GoForward => {
                log::info!("Vorwärts-Button gedrückt.");
            }
        }
        Task::none()
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
        let content_area = container(
            column![
                text(format!("Aktuelle URL: {}", self.current_url)).size(20),
                loading_status,
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

    // Fügt die Settings-Logik aus dem alten Program-Trait hier ein,
    // falls iced::application keine Settings::default() anwendet.

}