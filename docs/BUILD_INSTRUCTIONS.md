# Build Instructions – Oneapptredie

Questa guida spiega come compilare e testare l'app **Oneapptredie** sia per **Web** che per **Android (APK)**.

---

## 📋 Prerequisiti

### Flutter SDK
Scarica e installa Flutter: https://flutter.dev/docs/get-started/install

```bash
# Verifica l'installazione
flutter --version
flutter doctor
```

La versione minima richiesta è **Flutter 3.x** (Dart SDK ≥ 3.0.0).

### Android (solo per APK)
- Android Studio o SDK Command Line Tools
- Java 11 o superiore

---

## 🌐 Versione Web

### Build manuale

```bash
# 1. Installa dipendenze
flutter pub get

# 2. Compila per web
flutter build web --release

# 3. L'output sarà in:
#    build/web/
```

### Servire localmente

```bash
cd build/web
python3 -m http.server 8080
# Apri http://localhost:8080 nel browser
```

### Usare lo script di build

```bash
chmod +x build_scripts/build_web.sh
./build_scripts/build_web.sh
```

---

## 📱 Versione Android (APK)

### Build manuale

```bash
# 1. Installa dipendenze
flutter pub get

# 2. Compila APK in release
flutter build apk --release

# 3. L'APK sarà in:
#    build/app/outputs/flutter-apk/app-release.apk
```

### Installare su telefono

1. Abilita **"Origini sconosciute"** nelle impostazioni del tuo Android  
   *(Impostazioni → Sicurezza → Installa app sconosciute)*

2. Trasferisci il file APK sul telefono (via cavo USB, email o Google Drive)

3. Apri il file APK sul telefono e segui le istruzioni di installazione

### Installare via ADB (per sviluppatori)

```bash
# Con il telefono collegato via USB
adb install build/app/outputs/flutter-apk/app-release.apk
```

### Usare lo script di build

```bash
chmod +x build_scripts/build_apk.sh
./build_scripts/build_apk.sh
```

---

## 🔄 Build completo (Web + APK)

```bash
chmod +x build_scripts/build.sh
./build_scripts/build.sh
```

---

## ⬇️ Scaricare l'APK da GitHub Releases

Quando è disponibile un release su GitHub:

1. Vai su **GitHub → Releases** del repository
2. Scarica il file `app-release.apk` dall'ultima release
3. Installa sul telefono seguendo le istruzioni sopra

---

## 🔥 Firebase

L'app utilizza Firebase per autenticazione e salvataggio dati:

- **Web**: Firebase è disabilitato temporaneamente per il test web. Tutte le schermate funzionano in modalità locale.
- **Android/iOS**: Firebase viene inizializzato automaticamente all'avvio.

Per abilitare Firebase su web, aggiungere `google-services.json` (Android) e configurare le opzioni Firebase per web in `lib/firebase_options.dart`.

---

## 🛠️ Troubleshooting

### `flutter: command not found`
Aggiungere Flutter al PATH:
```bash
export PATH="$PATH:/path/to/flutter/bin"
```

### Errore `minSdkVersion`
Il `minSdkVersion` è impostato a **21** in `android/app/build.gradle`. Non abbassarlo.

### Errore dipendenze
```bash
flutter clean
flutter pub get
```

### Errore Firebase
L'app funziona senza Firebase. Se Firebase non è configurato, l'errore viene ignorato automaticamente.

### Errore build web – `Cannot open file`
```bash
flutter clean
flutter build web --release
```
