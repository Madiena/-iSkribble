# iSkribble

Ein [skribbl.io](https://skribbl.io/)-Klon geschrieben in Swift.

## Starten der Applikation

### Server

- In das Server Verzeichnis wechseln:<br>
`cd backend`

- Environment-Datei kopieren:<br>
`cp .env.example .env`

- Ggf. `.env` anpassen.

- Server starten:<br>
`swift run`

#### Anpassen der Wörterliste

Die Wörterliste ist in `backend/Resources/words.json` definiert.<br>
Hier können beliebig viele Wörter hinzugefügt oder gelöscht werden.<br>
Es können auch eigene Wörterlisten benutzt werden, das Format ist hierbei:<br>
```json
[
	"word1",
	"word2",
	...
	"wordn"
]
```

### Client

- In das Client Verzeichnis wechseln:<br>
`cd frontend/DrawingApp`

- XCode Project öffnen:<br>
`open DrawingApp.xcodeproj`

- Als Target ein beliebiges iPhone/iPod Touch auswählen
  
- App Starten

## Features

- Beliebige Anzahl an Räumen.
  - Wenn ein Raum nicht existiert, wird er einfach erstellt.
- Unbegrenzte Anzahl an Spielern in Räumen.
- Text-Chat.
  - Darüber wird auch das Wort erraten.
- Leinwand, welche in Echtzeit mit allen Teilnehmern synchronisiert wird.
  - Anpassbare Pinsel:
    - Linienstärke
    - Farbe
- Pinselstriche rückgängig machen und Leinwand komplett löschen.
- Jeder Maler kann zwischen drei zufälligen Wörtern wählen.
  - Wörterliste im Backend anpassbar.
- Automatische Reihenfolge der Maler.
  - Wenn das Wort erraten worden ist, ist direkt der nächste Spieler dran.

## Frameworks

- `Vapor` (Nur Server)
  - Server Framework für Swift
- `SwiftUI` (Nur Client)
- `CoreGraphics`
  - Grafik-Framework, welches für die Leinwand benutzt wird.
- `WebSocketKit`
  - Ermöglicht die Kommunikation zwischen Client und Server über WebSockets.
- `shared`
	- Ein lokales Modul, welches geteilte Datenstrukturen und Funktionalitäten zwischen Client und Server enthält.