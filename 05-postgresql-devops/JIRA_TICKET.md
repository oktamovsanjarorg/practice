# 🎫 JIRA TICKET: PAYPULSE-501

**Project:** PayPulse FinTech Core Infrastructure  
**Key:** PAYPULSE-501  
**Priority:** 🔴 P1 - Blocker  
**Reporter:** Head of SecOps & Lead DBA  
**Assignee:** Sanjar (Cloud & DevOps Engineer)  
**Status:** In Progress  

---

## 📌 Muammo Tavsifi

Salom Sanjar,  
Bank regulyatori (Markaziy Bank) va ichki xavfsizlik (SecOps) auditi natijasida PostgreSQL ma'lumotlar bazamizda bir nechta jiddiy xavfsizlik va barqarorlik kamchiliklari aniqlandi:

### 💥 0-Talab: Paket O'rnatish, Klastr va Systemd Boshqaruvi (Full OS Lifecycle)
* **Muammo:** Yangi Linux instansida PostgreSQL paketi, klastr ma'lumotlar papkasi yoki tizim xizmati sozlangan bo'lmasligi mumkin. Bare-metal yoki EC2 serverda noldan o'rnatish, initsializatsiya qilish va servisni avtomatik rejimga o'tkazish talab etiladi.
* **Qilinishi kerak:**
  1. Paket mavjudligini ta'minlang (`pacman -S postgresql` yoki o'rnatilganini tekshirish).
  2. Klastr yaratilmagan bo'lsa, `initdb` orqali `/var/lib/postgres/data` katalogini initsializatsiya qiling (`sudo -u postgres initdb -D /var/lib/postgres/data --locale=C.UTF-8`).
  3. `systemctl` orqali `postgresql.service` ni ishga tushiring (`start`) va boot vaqtida avtomatik yonishi uchun `enable` qiling.
  4. Baza porti (5433) va soketi to'g'ri ulanish qabul qilayotganini tekshiring (`psql -c 'SELECT 1;'`).

---

### 💥 1-Talab: Rollar Izolyatsiyasi (Principle of Least Privilege)
* **Muammo:** Hozirgi backend API xizmatlari superuser hisobidan ulanishga urinmoqda. Bu xavfsizlikka mutlaqo zid!
* **Qilinishi kerak:**
  1. Faqat API uchun mo'ljallangan alohida `paypulse_api` nomli role/foydalanuvchi yarating (LOGIN huquqi va xavfsiz parol bilan).
  2. Unga `paypulse_prod` bazasiga ulanish (CONNECT) huquqini bering.
  3. Unga faqat zaruriy `customers` va `transactions` jadvallariga (`SELECT, INSERT, UPDATE`) ruxsat bering.
  4. ⚠️ **Qat'iy taqiq:** `internal_audit_secrets` (bank maxfiy kalitlari) jadvaliga bu rolda ruxsat bo'lmasligi shart! Superuser yoki ortiqcha huquqlar berilmasin.

---

### 💥 2-Talab: Ishonchli Avtomatik Zaxiralash (Backup Pipeline)
* **Muammo:** Bazaning avtomatlashtirilgan zaxira nusxasi yo'q. Agar server qulasa, tranzaksiyalar yo'qoladi.
* **Qilinishi kerak:**
  1. `backup_prod.sh` nomli skript yarating va unga ijro huquqini bering (`chmod +x`).
  2. Skript ichida `pg_dump` vositasidan foydalanib, `paypulse_prod` bazasining zaxira nusxasini `backups/` katalogiga saqlang (Eng tavsiya etiladigan format: `-Fc` custom siqilgan format).

---

### 💥 3-Talab: Halokatdan Tiklash Sinovi (Disaster Recovery Drill)
* **Muammo:** Zaxira nusxasi borligi — uni tiklab bo'lishini anglatmaydi. Har bir DevOps muhandisi zaxiraning haqiqatda ishlashini sinovdan o'tkazishi shart.
* **Qilinishi kerak:**
  1. Zaxiradagi fayldan foydalanib, yangi `paypulse_recovery_test` nomli sinov bazasini yarating va ma'lumotlarni unga to'liq tiklang (`pg_restore` yoki `psql`).
  2. Barcha 3 ta mijoz va 3 ta tranzaksiya yangi bazada to'liq paydo bo'lishini ta'minlang.

---

## 🛠️ Diagnostika va Tekshirish Vositalari

* **PostgreSQL Porti:** `5433` *(Tizimingizda postgres aynan 5433-portda ishlamoqda)*
* **Superuser:** `sanjar` *(psql -p 5433 -U sanjar -d postgres)*
* **Nazariy qo'llanma:** `cat HANDBOOK.md`
* **Jonli telemetriya:** `./simulate.sh`
* **SRE audit tekshiruvi:** `./verify.sh`
