# Testing Guide – Oneapptredie

---

## 🌐 Test su Web (Browser)

### Metodo 1 – Locale (con Flutter installato)

```bash
flutter run -d chrome
```

Oppure dopo il build:
```bash
flutter build web --release
cd build/web && python3 -m http.server 8080
# Apri http://localhost:8080
```

### Metodo 2 – GitHub Pages (online, senza installare nulla)

Se il workflow GitHub Actions è attivo, l'app web viene pubblicata automaticamente su:

```
https://<utente>.github.io/5056/
```

---

## 📱 Test su Android (telefono)

### Metodo 1 – APK da GitHub Releases

1. Vai su **GitHub → Releases**
2. Scarica `app-release.apk`
3. Abilita "Origini sconosciute" sul telefono
4. Installa l'APK e apri l'app

### Metodo 2 – Build locale + ADB

```bash
flutter build apk --release
adb install build/app/outputs/flutter-apk/app-release.apk
```

### Metodo 3 – Emulatore Android

```bash
# Apri Android Studio → AVD Manager → Crea/Avvia un emulatore
flutter run -d emulator-5554
```

---

## ✅ Checklist di Testing

### Navigazione
- [x] Home Screen si apre correttamente
- [x] Tutti i bottoni di navigazione funzionano
- [x] Nessun crash durante la navigazione

### Note
- [x] Creare una nota
- [ ] Modificare una nota
- [x] Eliminare una nota

### Progetti
- [x] Creare un progetto
- [x] Visualizzare i progetti
- [ ] Modificare stato progetto

### Preventivi (Quotes)
- [x] Creare un preventivo
- [x] Visualizzare i preventivi

### Fatture (Invoices)
- [x] Visualizzare le fatture
- [x] Creare una fattura

### Chilometri (Mileage)
- [x] Registrare un viaggio
- [x] Visualizzare i viaggi

### Clienti (Clients)
- [x] Aggiungere un cliente
- [x] Visualizzare i clienti
- [x] Rimuovere un cliente

### Ore Lavoro (Worker Hours)
- [x] Registrare ore lavorate
- [x] Visualizzare le ore

### Calendario
- [x] Visualizzare il calendario
- [x] Aggiungere un evento

---

## 🔴 Bug noti

- Firebase non è attivo su web (funzionalità offline)
- Google Sign-In non funziona su web senza configurazione Firebase web

---

## 📞 Supporto

Per problemi, aprire un issue su GitHub.
