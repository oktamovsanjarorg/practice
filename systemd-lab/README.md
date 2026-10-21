# Systemd Service Troubleshooting Lab

Ushbu laboratoriyada 10 ta real ishlab chiqarishda uchraydigan noto'g'ri sozlangan `systemd` service fayllari keltirilgan.
Har bir faylda aniq bitta (yoki ikkita) muhim xato/kamchilik bor.

## Fayllar ro'yxati:
1. `challenge-01.service` — Yo'llar bilan bog'liq klassik xato.
2. `challenge-02.service` — Sintaksis / Seksiyalar bilan bog'liq xato.
3. `challenge-03.service` — Ishchi papka (WorkingDirectory) xatosi.
4. `challenge-04.service` — Ruxsatlar va User (Permissions) ziddiyati.
5. `challenge-05.service` — Xizmat turi (`Type=`) xatosi.
6. `challenge-06.service` — Avtomat yuklanish (Autostart/Boot) konfiguratsiyasi yetishmasligi.
7. `challenge-07.service` — Buyruq direktivasi xatosi.
8. `challenge-08.service` — Tarmoq va DNS tayyorligini kutish (`network-online.target`).
9. `challenge-09.service` — Restart bo'roni (Restart rate-limiting) himoyasi.
10. `challenge-10.service` — Muhit o'zgaruvchilari fayli (`.env`) direktivasi xatosi.

---
Vazifa: Fayllarni birma-bir ko'rib chiqing va qaysi qatorda nima xato ekanligini toping!
