// Importiere die Tauri-Funktion, um Rust-Commands aufzurufen
import { invoke } from '@tauri-apps/api/core';

// Setup Canvas
const canvas = document.getElementById('render-canvas');
const ctx = canvas.getContext('2d');
const tauri_invoke_handler = window.__TAURI__.core

// Die Abmessungen unseres Dummy-Frames (müssen mit dem Rust-Core übereinstimmen!)
const FRAME_WIDTH = 640;
const FRAME_HEIGHT = 480;
let counter = 0;

// Setze die tatsächliche Rendergröße des Canvas
canvas.width = FRAME_WIDTH;
canvas.height = FRAME_HEIGHT;
/**
 * Ruft den gerenderten Frame vom Rust-Backend ab und zeichnet ihn auf das Canvas.
 */
async function drawFrame() {
    try {
        // Ruft das Rust-Kommando auf. Rust gibt Vec<u8> (Pixel) zurück.
        // Tauri wandelt dies in einen ArrayBuffer (JS-seitig) um.
        const pixelArrayBuffer = await tauri_invoke_handler.invoke('get_current_frame');

        // Umwandlung des ArrayBuffers in ein Uint8ClampedArray für ImageData
        const pixelData = new Uint8ClampedArray(pixelArrayBuffer);

        // Erstelle ein ImageData-Objekt (R, G, B, A). Wir haben R, G, B (3 Bytes),
        // müssen aber Alpha (4. Byte) hinzufügen.
        const imageData = ctx.createImageData(FRAME_WIDTH, FRAME_HEIGHT);

        let dataIndex = 0;
        for (let i = 0; i < pixelData.length; i += 3) {
            // R, G, B
            imageData.data[dataIndex++] = pixelData[i];
            imageData.data[dataIndex++] = pixelData[i + 1];
            imageData.data[dataIndex++] = pixelData[i + 2];
            // A (Alpha-Wert, 255 = volle Deckkraft)
            imageData.data[dataIndex++] = 255;
        }

        // Zeichne die fertigen Daten auf das Canvas
        ctx.putImageData(imageData, 0, 0);

    } catch (e) {
        // Dieser Fehler sollte jetzt nicht mehr auftreten, da die Cargo.toml korrigiert wurde.
    }
}

// Starte den Frame-Rendering-Loop (kann später durch Events ersetzt werden)
function renderLoop() {
    document.getElementById('address-bar').placeholder = "counter: " + counter;
    counter = counter + 1;
    drawFrame();
    setTimeout(renderLoop, 100);
}

function test() {
    document.getElementById('address-bar').placeholder = "moin";
}

// Starte den Loop, sobald das Skript geladen ist
renderLoop();