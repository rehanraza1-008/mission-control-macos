# 🛰️ Mission Control

A productivity operating system for macOS featuring voice automation, study-session enforcement, recurring accountability check-ins, and a live schedule dashboard.

Mission Control was built to solve a simple problem:

Traditional calendars and reminder applications are passive. They wait for the user to engage with them. Mission Control takes the opposite approach by actively enforcing a structured schedule through automation, voice announcements, notifications, and real-time task tracking.

---

## ✨ Features

### 📊 Live Dashboard

A lightweight dashboard built using HTML, CSS, and JavaScript that displays:

* Current time
* Current task
* Upcoming task
* Real-time schedule progression

Designed to remain open throughout the day as a personal command center.

---

### 🔊 Voice Automation Engine

Powered by Hammerspoon and Lua.

Mission Control automatically announces:

* Wake-up alarms
* Study block transitions
* Prayer reminders
* Meal breaks
* Daily review sessions
* End-of-day shutdown reminders

Example:

> "Math Block Two begins now."

> "Dhuhr prayer and lunch."

---

### ⏱️ Productivity Enforcement System

Powered by Bash and macOS LaunchAgents.

During active study sessions, Mission Control automatically performs periodic accountability check-ins and calculates remaining session duration.

Example notification:

> 📐 Math Block 2 — CHECK IN
> 📐 3h 2m remaining — Are you still working?

---

### ⚙️ Native macOS Automation

Mission Control uses native macOS services instead of heavy background applications.

Components include:

* LaunchAgents
* AppleScript
* Bash Scripts
* Hammerspoon
* System Notifications
* Text-to-Speech Automation

---

## 🏗️ Architecture

```text
Mission Control
│
├── timetable.html      → Dashboard Interface
├── init.lua            → Voice Automation Engine
├── alarm.sh            → Schedule Transition Alerts
├── nag.sh              → Accountability Check-In System
├── setup.sh            → Automated Installation Script
│
└── LaunchAgents
      ├── Alert Service
      └── Productivity Monitoring Service
```

---

## 🚀 Installation

```bash
git clone https://github.com/rehanraza1-008/mission-control-macos.git

cd mission-control-macos

chmod +x setup.sh

./setup.sh
```

---

## 🛠️ Tech Stack

### Frontend

* HTML
* CSS
* JavaScript

### Automation

* Bash
* AppleScript
* LaunchAgents

### System Integration

* Hammerspoon
* Lua

### Version Control

* Git
* GitHub

---

## 🎯 Why I Built This

I wanted a system that would actively help maintain discipline rather than simply display a timetable.

Mission Control combines scheduling, automation, and accountability into a single lightweight workflow designed for deep work, study sessions, and structured routines.

---

## 🗺️ Roadmap

* [ ] Daily productivity analytics
* [ ] Study-time reports
* [ ] Application blocking during focus sessions
* [ ] Calendar integration
* [ ] Cross-device synchronization
* [ ] AI-powered productivity coaching

---

## 👤 Author

**Rehan Raza**

GitHub: @rehanraza1-008
