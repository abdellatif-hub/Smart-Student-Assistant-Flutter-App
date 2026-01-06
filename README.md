# 🎓 Smart Student Assistant — Flutter App

> Application mobile Flutter développée dans le cadre du **devoir de synthèse**,  
> visant à regrouper les compétences acquises en **Dart**, **Flutter**, **navigation**,  
> **API REST (Retrofit + Dio)**, **chatbot**, et **thèmes globaux**.

> **base de données vectorielle**, et **frontend de discussion**.

>  Application de chatbot intelligente basée sur l’architecture

> **RAG (Retrieval-Augmented Generation)**, combinant **backend Python**, 
---

## 🎯 Objectifs de l’application

L’application **Smart Student Assistant** a pour objectif d’aider un étudiant dans son
environnement académique en proposant :

- Une interface claire et cohérente
- Une navigation simple via un menu latéral (Drawer)
- Des pages informatives
- Un chatbot connecté à une API REST
- Un thème global professionnel et centralisé

---

## 🧱 Architecture du projet
### Backend (RAG – Python)
```
rag_multi_modal/
│── api.py # API FastAPI pour requêtes GET
│── app.py # Application Streamlit
│── db.py # Connexion PostgreSQL
│── db.sql # Création de la table pgvector
│── docker-compose.yml # PostgreSQL + pgvector
│── ingest.py # Pipeline ingestion PDF + images
│── openai_utils.py # Caption + Embedding
│── rag_core.py # Retrieval + génération RAG
│── requirements.txt # Dépendances
│── data/ # Dossier PDF/Images à indexer
│── venv/ # Environnement virtuel
```
<img width="730" height="827" alt="image" src="https://github.com/user-attachments/assets/498363e8-f37b-43b9-9a94-4557a1505a19" />


### 🧭 Architecture globale Backend / Frontend

````
Utilisateur
   │
   ▼
Frontend (Web / Mobile)
   │
   ▼
API Backend (Python)
   │
   ├── Ingestion PDF
   ├── Recherche vectorielle
   ├── RAG Core
   └── LLM
   │
   ▼
Réponse affichée

````

---

# 2️⃣ Lancer PostgreSQL + pgvector
````
docker-compose up -d
````

<img width="1859" height="157" alt="image" src="https://github.com/user-attachments/assets/55004808-f5f0-43af-bdf7-da5b59127509" />

---
# 3️⃣ Créer et activer le virtualenv
````
python -m venv venv
venv\Scripts\activate.bat
````
<img width="1866" height="81" alt="image" src="https://github.com/user-attachments/assets/43934159-d006-4c6e-99a2-674c8245397e" />

<img width="1861" height="89" alt="image" src="https://github.com/user-attachments/assets/73a44f4a-0ef9-4af8-8b01-70ab755a02ef" />

---
# 4️⃣ Installer les dépendances
````
pip install -r requirements.txt
````

<img width="1864" height="1104" alt="image" src="https://github.com/user-attachments/assets/a7368bb9-fa89-4b37-9921-ad692e811c92" />

---
# 📥 Ingestion des PDF et images

## Ajoute tes fichiers dans :

````
data/
````
<img width="2557" height="1079" alt="image" src="https://github.com/user-attachments/assets/0943f6b6-6a6d-4f18-acc0-0a5327d3499d" />

## Puis lance :
````
python ingest.py
````

## ✔ Résultat attendu

<img width="1871" height="187" alt="image" src="https://github.com/user-attachments/assets/c4bb7df1-904f-4b90-8b6e-19177b078d69" />

---
# 🌐 API REST (FastAPI)

## ✅ 1. Crée un fichier api.py
<img width="2559" height="1146" alt="image" src="https://github.com/user-attachments/assets/7aadf4d8-c020-4587-9226-435e46ab8ed6" />

---
## ✅ 2. Installer FastAPI + Uvicorn 
````
pip install fastapi uvicorn
````
<img width="1863" height="1167" alt="image" src="https://github.com/user-attachments/assets/bf6607db-bc21-4b40-9ebc-a9737fb5b078" />

## ✅ 3. Lancer l’API
````
uvicorn api:app --reload
````
<img width="1847" height="1074" alt="image" src="https://github.com/user-attachments/assets/713f570b-f6c0-4fce-b16c-142d0a487542" />

---
## ✅ 4. Tester dans le navigateur ou Postman
````
Méthode : GET
````
<img width="1802" height="1205" alt="image" src="https://github.com/user-attachments/assets/66b1f138-709f-4525-aea3-50b5e3c3abf3" />

---

````
Méthode : POST
````

<img width="2559" height="1345" alt="image" src="https://github.com/user-attachments/assets/46c53840-93fd-4112-b40e-37702d97a3da" />







---
# 🔹 Frontend
- Interface de discussion (client)
- Communication avec l’API Backend
- Affichage des réponses du chatbot


---
## 🧱 Architecture du projet
### Frontend 
````
frontend/
├── lib/
│   ├── main.dart
│   │
│   ├── pages/
│   │   ├── home_page.dart
│   │   ├── chatbot_page.dart
│   │   ├── profile_page.dart
│   │   ├── settings_page.dart
│   │   └── about_page.dart
│   │
│   ├── widgets/
│   │   └── app_drawer.dart
│   │
│   ├── theme/
│   │   ├── app_colors.dart
│   │   └── app_theme.dart
│   │
│   ├── api/
│   │   ├── rag_api.dart
│   │   └── rag_api.g.dart
│   │
│   ├── models/
│   │   ├── rag_response.dart
│   │   └── rag_response.g.dart
│   │
│   └── services/
│       └── api_service.dart
│
├── assets/
│   └── profile.jpg
│
├── pubspec.yaml
└── README.md

````

<img width="2485" height="1207" alt="image" src="https://github.com/user-attachments/assets/a386fd42-2efe-4219-ba1e-4937a37d296a" />


---

## 🎨 Thème global & design

- Les couleurs sont centralisées dans `app_colors.dart`
- Le thème global est défini dans `app_theme.dart` via `ThemeData`
- Le thème gère :
  - AppBar
  - Textes
  - Boutons
  - Drawer
- ❌ Aucune couleur n’est codée directement dans les widgets
- Tous les styles sont récupérés via `Theme.of(context)`

---

## 🧭 Navigation & menu latéral

- Un **Drawer** est accessible depuis la page Accueil
- Il contient :
  - Un avatar (image locale)
  - Le nom et l’email de l’étudiant
- Navigation vers les pages :
  - Accueil
  - Profil
  - Paramètres
  - À propos
  - Chatbot

---



### 📄 pubspec.yaml 
```
name: theme_dem_g1
description: "Flutter TP - Styling et Thèmes"
publish_to: 'none'

version: 1.0.0+1

environment:
  sdk: ^3.9.2

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0

flutter:
  uses-material-design: true

  assets:
    - assets/profile.jpg
```

---

## ▶️ Lancer le projet

```bash
flutter clean
flutter pub get
flutter run
```
---

### 🏠 Page Accueil
<img width="2555" height="1167" alt="image" src="https://github.com/user-attachments/assets/96ad1b4d-b4be-4b57-bc67-aade0bc93498" />

### 🗃️ drawer 
<img width="488" height="1035" alt="Capture d&#39;écran 2026-01-05 233503" src="https://github.com/user-attachments/assets/310d95bd-f858-410a-8f27-6f89701c1b2f" />


### 👤 Page Profil
<img width="2559" height="1170" alt="image" src="https://github.com/user-attachments/assets/1e33e1b3-573e-46e9-9686-7bf25613eb65" />



### ⚙️ Page Paramètres
<img width="2559" height="1161" alt="image" src="https://github.com/user-attachments/assets/a751ae19-1905-499a-bd1a-dd621ab22a45" />


### ℹ️ Page À propos
<img width="2559" height="1152" alt="image" src="https://github.com/user-attachments/assets/738e61d4-99b3-4f11-876e-440f21890c5c" />


### ℹ️ Page Chatbot
<img width="495" height="1049" alt="Capture d&#39;écran 2026-01-05 232607" src="https://github.com/user-attachments/assets/7c257e09-74d7-4525-9e34-fbb29af4a7b2" />
<img width="491" height="1046" alt="Capture d&#39;écran 2026-01-05 232632" src="https://github.com/user-attachments/assets/eed61b47-9316-41c1-ac30-f174ff9a2aa6" />

---
# ✅ Contraintes respectées

-  Thème global centralisé

 - Aucune couleur codée directement

 - Navigation avec Drawer

 - Pages informatives complètes

 - Chatbot fonctionnel

 - Retrofit + Dio

 - Pas de state management avancé

 - Structure claire du projet
   
---

# 🏁 Conclusion

Ce projet permet de consolider les bases du développement mobile avec Flutter en appliquant
les bonnes pratiques professionnelles : structuration du code, séparation des responsabilités,
gestion des thèmes et intégration d’API REST.
L’application Smart Student Assistant constitue une base solide pour des projets Flutter
plus avancés.






