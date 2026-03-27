# Oneapptredie Flutter App

---

## 🚀 COME OTTENERE L'APP PER TESTARLA – ISTRUZIONI IMMEDIATE

> ✅ **Soluzione definitiva:** Fai il merge di questa PR su `main` → da quel momento il build parte **da solo, automaticamente**, ogni volta che il bot completa il suo lavoro. Non devi più fare nulla.

### PASSO 1 — Fai il merge della PR (una volta sola, poi non serve più)

1. Apri: **[https://github.com/vincecosmano/5056/pulls](https://github.com/vincecosmano/5056/pulls)**
2. Clicca sulla PR aperta
3. Scorri in fondo → clicca il pulsante verde **"Merge pull request"** → **"Confirm merge"**
4. ✅ Fatto! Da questo momento ogni sessione di Copilot avvia il build automaticamente

### PASSO 2 — Avvia il primo build adesso (dopo il merge)

1. Apri: **[https://github.com/vincecosmano/5056/actions](https://github.com/vincecosmano/5056/actions)**
2. Nella colonna sinistra clicca su **"Build – Web & Android APK"**
3. Clicca il pulsante grigio **"Run workflow"** a destra
4. Clicca il pulsante verde **"Run workflow"**
5. Aspetta ~10 minuti

### Dove trovi l'app dopo il build

| Piattaforma | Link diretto |
|-------------|-------------|
| 📱 **Android APK** | [github.com/vincecosmano/5056/releases/latest](https://github.com/vincecosmano/5056/releases/latest) → scarica `app-release.apk` |
| 🌐 **App Web** | [vincecosmano.github.io/5056/](https://vincecosmano.github.io/5056/) |

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
