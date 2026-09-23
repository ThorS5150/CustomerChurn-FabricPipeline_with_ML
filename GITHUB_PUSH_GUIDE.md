# How to Push to GitHub - Schritt für Schritt

## Schritt 1: Repository auf GitHub erstellen

1. Gehen Sie zu https://github.com/new
2. **Repository Name**: `fabric-powerbi-adventureworks`
3. **Description**: Professional analytics solution with Microsoft Fabric and Power BI using AdventureWorksDW2022
4. **Visibility**: Public (für Recruiter sichtbar)
5. Klicken Sie **"Create repository"**

## Schritt 2: Auf Ihrem Computer - Git initialisieren

Öffnen Sie PowerShell im Ordner `C:\Users\Thorty\Desktop\Coworker\Projekte für GitHub\Fabric_PowerBI`:

```bash
# Git initialisieren
git init

# Alle Dateien hinzufügen
git add .

# Erster Commit
git commit -m "Initial commit: Fabric PowerBI AdventureWorks analytics project"

# Main Branch umbenennen
git branch -M main

# Remote Repository hinzufügen (ersetzen Sie mit Ihrer URL)
git remote add origin https://github.com/ThorS5150/fabric-powerbi-adventureworks.git

# Zum GitHub pushen
git push -u origin main
```

## Schritt 3: Power BI Dateien hinzufügen

Nach dem ersten Push:

```bash
# Kopieren Sie Ihre .pbix Dateien in den /reports Ordner
# Dann:
git add reports/
git commit -m "Add Power BI report files"
git push
```

## Schritt 4: GitHub-Seite prüfen

1. Gehen Sie zu https://github.com/ThorS5150/fabric-powerbi-adventureworks
2. Prüfen Sie, dass alle Dateien da sind
3. README sollte automatisch angezeigt werden

## Was Recruiter sehen werden

✅ Professional README  
✅ Komplette SQL-Scripts  
✅ Datenmodell-Dokumentation  
✅ Setup-Guide  
✅ Commit-Historie (zeigt Professionalism)  

## Typische Git-Befehle später

```bash
# Status checken
git status

# Änderungen ansehen
git diff

# Commits ansehen
git log --oneline

# Neu hinzufügen und pushen
git add .
git commit -m "Your message"
git push
```

## Troubleshooting

### Error: "remote origin already exists"
```bash
git remote remove origin
git remote add origin https://github.com/ThorS5150/fabric-powerbi-adventureworks.git
```

### Error: "Authentication failed"
- Verwenden Sie Personal Access Token statt Passwort
- GitHub Settings → Developer settings → Personal access tokens

---

**Ihre Repository-URL nach dem Push:**
```
https://github.com/ThorS5150/fabric-powerbi-adventureworks
```

Teilen Sie diese URL mit Recruiters, LinkedIn, und Bewerbungen! 🎉
