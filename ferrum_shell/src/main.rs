use tao::{
    event::{Event, StartCause, WindowEvent},
    event_loop::{ControlFlow, EventLoop},
    window::WindowBuilder,
};
use wry::WebViewBuilder;
use log::{info, error};
use std::env; // Für das Setzen der Umgebungsvariablen

// Wichtig: gtk muss als Abhängigkeit in Cargo.toml vorhanden sein.
#[cfg(target_os = "linux")]
use gtk;

// --- DAS UI OVERLAY (HTML/CSS/JS) ---
const OVERLAY_UI_SCRIPT: &str = r#"
(function() {
    let input = document.getElementById('ferrum-input');
    if (document.getElementById('ferrum-overlay')) {
        if (input) {
            input.value = window.location.href;
        }
        return;
    }

    const overlay = document.createElement('div');
    overlay.id = 'ferrum-overlay';
    overlay.innerHTML = `
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;700&display=swap');

            #ferrum-overlay {
                position: fixed;
                top: 10px;
                left: 50%;
                transform: translateX(-50%);
                width: 600px;
                max-width: 90%;
                /* Das Overlay bleibt dunkel, damit es gut lesbar ist */
                background: rgba(31, 41, 55, 0.95);
                backdrop-filter: blur(10px);
                padding: 10px;
                border-radius: 12px;
                box-shadow: 0 10px 25px rgba(0,0,0,0.5);
                z-index: 2147483647;
                display: flex;
                gap: 10px;
                font-family: 'Inter', sans-serif;
                transition: opacity 0.3s;
                opacity: 0.8;
            }
            #ferrum-overlay:hover {
                opacity: 1;
            }
            #ferrum-input {
                flex-grow: 1;
                background: #374151;
                border: 1px solid #4b5563;
                color: white;
                padding: 8px 12px;
                border-radius: 6px;
                outline: none;
                transition: border-color 0.2s, box-shadow 0.2s;
            }
            #ferrum-input:focus {
                border-color: #3b82f6;
                box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.5);
            }
            #ferrum-btn {
                background: #3b82f6;
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 6px;
                cursor: pointer;
                font-weight: bold;
                transition: background 0.2s, transform 0.1s;
            }
            #ferrum-btn:hover {
                background: #2563eb;
            }
            #ferrum-btn:active {
                transform: scale(0.98);
            }
        </style>
        <input type="text" id="ferrum-input" placeholder="URL eingeben..." />
        <button id="ferrum-btn">GO</button>
    `;

    document.body.appendChild(overlay);

    input = document.getElementById('ferrum-input');
    const btn = document.getElementById('ferrum-btn');

    input.value = window.location.href;

    function navigate() {
        let url = input.value.trim();
        if (url && !url.match(/^[a-zA-Z]+:\/\//)) {
            url = 'https://' + url;
        }
        window.location.href = url;
    }

    btn.addEventListener('click', navigate);
    input.addEventListener('keydown', (e) => {
        if (e.key === 'Enter') {
            e.preventDefault();
            navigate();
        }
    });
})();
"#;

fn main() {
    env_logger::init();

    // ********** FIX **********
    #[cfg(target_os = "linux")]
    {
        // Setze diese Umgebungsvariablen ZUERST!
        env::set_var("GTK_THEME", "Adwaita");
        env::set_var("GTK_COLOR_SCHEME", "prefer-light");
        env::set_var("WEBKIT_FORCE_SANDBOX", "0");
        env::set_var("WEBKIT_DISABLE_DARK_MODE", "1"); // <-- Dies ist der nukleare Fix
    }
    // *************************

    info!("Starte Ferrum Browser mit Wry...");

    #[cfg(target_os = "linux")]
    if gtk::init().is_err() {
        error!("Fehler beim Initialisieren von GTK.");
        return;
    }

    let event_loop = EventLoop::new();
    let window = WindowBuilder::new()
        .with_title("Ferrum Browser")
        .with_inner_size(tao::dpi::LogicalSize::new(1200.0, 800.0))
        .build(&event_loop)
        .expect("Fehler beim Erstellen des Fensters.");

    let mut webview: Option<wry::WebView> = None;

    event_loop.run(move |event, _, control_flow| {
        *control_flow = ControlFlow::Wait;

        match event {
            Event::NewEvents(StartCause::Init) => {
                info!("Event loop initialisiert. Erstelle WebView...");

                if webview.is_none() {
                    match WebViewBuilder::new()
                        .with_url("https://www.google.com")
                        .with_initialization_script(OVERLAY_UI_SCRIPT)
                        .with_ipc_handler(|msg| {
                            info!("IPC-Nachricht von WebView: {:?}", msg);
                        })
                        .with_devtools(true)
                        .build(&window)
                    {
                        Ok(wv) => {
                            info!("Wry WebView erfolgreich gestartet.");
                            webview = Some(wv);
                        }
                        Err(e) => {
                            error!("Fehler beim Starten des WebView: {}", e);
                            *control_flow = ControlFlow::Exit;
                        }
                    }
                }
            },
            Event::WindowEvent {
                event: WindowEvent::CloseRequested,
                ..
            } => {
                *control_flow = ControlFlow::Exit
            },
            _ => (),
        }
    });
}