# Oneapptredie Flutter App

---

## 🚀 COME OTTENERE L'APP – ISTRUZIONI PASSO DOPO PASSO

---

### 📖 Cos'è una "PR"?

Una **PR (Pull Request)** è una proposta di modifica al codice che il bot Copilot ha preparato per te.
È come un "pacchetto di modifiche" che aspetta la tua approvazione prima di essere salvato definitivamente nel tuo progetto.
**Finché non la approvi (merge), le modifiche non sono attive.**

In questo caso la PR contiene la correzione che fa partire i build automaticamente.

---

### PASSO 1 — Apri e accetta la PR (una volta sola)

👉 **Clicca direttamente qui:** **[https://github.com/vincecosmano/5056/pull/4](https://github.com/vincecosmano/5056/pull/4)**

Poi segui questi passi nella pagina che si apre:

1. Scorri la pagina fino **in fondo** (ignora tutto il testo tecnico sopra)
2. Vedrai un **riquadro verde** con scritto **"Merge pull request"**
3. Clicca il pulsante verde **"Merge pull request"**
4. Appare un secondo pulsante verde **"Confirm merge"** → cliccalo
5. ✅ **Fatto!** La pagina diventa viola con scritto "Pull request successfully merged and closed"

> ⚠️ **Se il pulsante è grigio invece che verde** e dice "This branch has conflicts": scrivi un nuovo messaggio a Copilot chiedendo di risolvere i conflitti.

---

### PASSO 2 — Avvia il primo build manuale (dopo il merge)

1. Apri: **[https://github.com/vincecosmano/5056/actions/workflows/build.yml](https://github.com/vincecosmano/5056/actions/workflows/build.yml)**
2. Vedrai un pulsante grigio **"Run workflow"** in alto a destra
3. Cliccalo → appare un piccolo menù → clicca il pulsante verde **"Run workflow"**
4. ⏳ Aspetta circa 10 minuti (vedrai girare dei cerchi colorati)

### Dove trovi l'app dopo il build

| Piattaforma | Link diretto |
|-------------|-------------|
| 📱 **Android APK** | **[Clicca qui → Releases](https://github.com/vincecosmano/5056/releases/latest)** → poi clicca `app-release.apk` per scaricarla sul telefono |
| 🌐 **App Web** | **[vincecosmano.github.io/5056/](https://vincecosmano.github.io/5056/)** → apri nel browser |

---

### ℹ️ Dopo il merge: tutto automatico

Da quando hai fatto il merge del PASSO 1, **ogni volta che Copilot finisce di lavorare**, il build parte da solo senza che tu faccia nulla. Trovi sempre l'ultima versione ai link sopra.

---

## 📊 Stato di avanzamento (Progress Summary)

### Moduli implementati ✅
| Modulo | Descrizione | Stato |
|--------|-------------|-------|
| **Note** | Creazione, modifica e cancellazione di note | ✅ Completo |
| **Progetti** | Gestione progetti con stato | ✅ Completo |
| **Clienti** | Rubrica clienti (add/remove) | ✅ Completo |
| **Fatture** | Creazione fatture con scadenza e importo | ✅ Completo |
| **Ore lavoro** | Registrazione ore lavorate per progetto | ✅ Completo |
| **Calendario** | Agenda eventi con date | ✅ Completo |
| **Preventivi** | Creazione preventivi per cliente | ✅ Completo |
| **Chilometri** | Tracciamento percorsi e costo rimborso | ✅ Completo |
| **Login Google** | Autenticazione via Google OAuth | ✅ Completo |
| **Home Dashboard** | Griglia con icone e descrizioni per ogni modulo | ✅ Completo |

### Da completare 🔲
- [ ] Persistenza dati su Firebase (attualmente solo in memoria)
- [ ] Firebase Web (Google Sign-In su browser)
- [ ] Schermata profilo utente
- [ ] Export PDF per fatture e preventivi
- [ ] Notifiche push (scadenze fatture, eventi calendario)

### CI/CD ✅
- Build web automatico → GitHub Pages (build funzionante; Google Sign-In su web richiede configurazione Firebase aggiuntiva)
- Build APK release → GitHub Releases

---

## Setup Instructions (sviluppo locale)
   ```bash
   git clone https://github.com/vincecosmano/5056.git
   cd 5056
   ```
2. Install Flutter from [flutter.dev](https://flutter.dev/docs/get-started/install).
3. Install the necessary packages:
   ```bash
   flutter pub get
   ```

## Features Overview
- User Authentication via Google OAuth
- Real-time data synchronization with Firebase
- Comprehensive UI with responsive design
- Integration with third-party libraries for enhanced functionality

## Development Guide
- Use Visual Studio Code or Android Studio for development.
- Run the app on an emulator or connected device:
   ```bash
   flutter run
   ```
- Follow the best practices for Flutter development.

## Firebase Setup
1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/).
2. Register your app in the Firebase project.
3. Download the `google-services.json` for Android and place it in `android/app/`.
4. Configure Firebase in the Flutter app according to the official documentation:
   - [Add Firebase to Your Flutter App](https://firebase.flutter.dev/docs/overview/)

## Google OAuth Setup
1. Go to [Google Cloud Console](https://console.cloud.google.com/).
2. Create a new project or select an existing one.
3. Enable "Google+ API" in your project.
4. Set up OAuth 2.0 credentials and download the `client_id.json`.
5. Add the necessary configuration to your Flutter app:
   - Follow the instructions in [Google Sign-In for Flutter](https://pub.dev/packages/google_sign_in)

## CI / CD

The repository includes a GitHub Actions workflow (`.github/workflows/build.yml`) that automatically:

- **Builds the Flutter web app** and uploads the artifact
- **Deploys to GitHub Pages** on every push to `main`
- **Builds the Android release APK** and uploads it as an artifact
- **Creates a GitHub Release** with the APK attached on every push to `main`

Android launcher icons (`mipmap-*`) are provided at all standard densities so the APK resource-linking step succeeds without additional setup.

## Deployment Instructions
1. Build the app for release:
   ```bash
   flutter build apk --release
   ```
2. Deploy the APK to desired app stores or distribute it directly.
3. Follow platform-specific guidelines for deployment (Google Play Store, etc.).

---

### License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### Acknowledgements
- Flutter team
- Firebase team
- Google Cloud team
