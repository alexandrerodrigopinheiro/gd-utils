# GD Utils

> 🧮 Utility library for the Godot Engine (GDScript)  
> Includes formatting, datetime handling, and general-purpose helper functions.

---

## 🧭 Overview

**GD Utils** is a lightweight, modular utility library written in GDScript for use in **Godot Engine** projects.  
It offers ready-to-use helpers for value formatting, string manipulation, date/time operations, and general scripting needs.

The scripts are intended to be imported and reused across multiple projects, enhancing consistency and reducing boilerplate code.

---

## ✨ Features

- 💰 Currency formatting
- 🕒 Date & time parsing, formatting, and offsets
- 🔢 Number formatting
- 🔧 General-purpose helper functions (`utils.gd`)
- 🧪 Sandbox test scene included

---

## 📂 Files

| File             | Description                            |
|------------------|----------------------------------------|
| `format.gd`      | Format numbers, currency, decimals     |
| `datetime.gd`    | Handle and format date/time operations |
| `utils.gd`       | Miscellaneous utilities and shortcuts  |
| `sandbox.gd`     | Example usage script                   |
| `sandbox.tscn`   | Demo scene to preview the tools        |

---

## 📦 Usage

Copy the `scripts/` folder into your Godot project or link it as a submodule.

Example usage:

```gdscript
var formatted = Format.to_currency(1299.95)
var now = DateTime.get_now_formatted()
```

---

## 🛠 Requirements

- Godot Engine 3.5+ or 4.x
- No external dependencies
- Compatible with GDScript only

---

## 🧪 Testing

Open `sandbox.tscn` in the Godot editor and run it to preview formatting behavior.

---

## 🚀 Recommended Integration

- Set `format.gd`, `datetime.gd`, or `utils.gd` as **Autoloads** in your project for global access
- Alternatively, preload them as singletons where needed:

```gdscript
const Format = preload("res://scripts/format.gd")
const DateTime = preload("res://scripts/datetime.gd")
```

---

## 🧾 License

This project is distributed under the **Unlicense** — public domain.  
Use it freely for personal, commercial, or educational projects.

---

## 🤝 Contributions

Contributions welcome!  
Feel free to open issues or pull requests for improvements, new utility methods, or fixes.
