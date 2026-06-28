# 🛠️ Templates & Rules (Developer OS)

Репозиторий для хранения личных шаблонов, правил для AI-агентов и конфигураций рабочего окружения. Это «база знаний как код», которая помогает поддерживать единый стандарт качества во всех проектах.

---

## 📂 Структура проекта

### 🤖 [Claude code](./Claude%20code)
Центральный хаб правил для AI-агентов (Claude, Junie, GitHub Copilot).
- **rules-library/** — библиотека специфичных правил для FastAPI, Clean Architecture, Python Core и работы с данными.
- **project-template/** — эталонная структура проекта с настроенным `CLAUDE.md` и `ruff.toml`.

### 👤 [FrostWillmott](./FrostWillmott)
Шаблон для оформления профиля GitHub.

### 🏠 Startpages
Персональные стартовые страницы для браузера:
- **[devs_startpage](./devs_startpage)**
- **[startpage](./startpage)**

### 📦 [Archive](./archive)
Архив инструментов и конфигураций, которые временно не используются (например, настройки VS Code после перехода на PyCharm).

---

## 🚀 Технологический стек (Core)

- **Language:** Python 3.12+ (Ruff for linting/formatting)
- **Framework:** FastAPI
- **Architecture:** Clean Architecture (Domain, Use Cases, Infrastructure)
- **Database:** PostgreSQL + pgvector
- **Tooling:** Docker, Pytest, SQLAlchemy (async)

---

## 🛠 Использование

Для применения правил в новом проекте:
1. Скопируйте содержимое `Claude code/project-template` в корень вашего нового проекта.
2. В файле `CLAUDE.md` укажите ссылки на необходимые правила из `rules-library`.
3. Настройте `ruff.toml` для соблюдения стандартов кодинга.

---

## 🔄 Обновление AGENTS.md

В конце каждой сессии работы с Junie рекомендуется запускать команду:
`Update .junie/AGENTS.md with what we discovered today about the project structure and current issue`

Это поможет агенту сохранять контекст о ваших предпочтениях и архитектурных решениях.
