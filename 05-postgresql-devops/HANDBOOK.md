# 📘 5-BOSQICH HANDBOOK: POSTGRESQL FOR DEVOPS & SRE ARCHITECTURE

Dasturchilar (developers) PostgreSQL'ni murakkab SQL so'rovlar, ORM va biznes logika nuqtai nazaridan ko'rishadi.
**DevOps va Cloud muhandislari** esa PostgreSQL'ga butunlay boshqacha — **infratuzilma, xavfsizlik, chidamlilik (resilience) va barqarorlik** ko'zi bilan qaraydilar.

Ushbu qo'llanma sizga PostgreSQL'ning ichki mexanizmlari, konfiguratsiya sirlari, xavfsiz rollar siyosati hamda zaxiralash (Backup & Restore) amaliyotini o'rgatadi.

---

## 🏛️ 1-Qism: PostgreSQL Tizim Arxitekturasi

PostgreSQL — ko'p jarayonli (multi-process) mijoz-server arxitekturasiga ega.

```
       [ Client / App ]  (Backend, Python, Node.js)
              │
         Port: 5432 / 5433
              ▼
   ┌──────────────────────────────────────────────┐
   │         POSTMASTER (Bosh Jarayon)            │
   └──────┬────────────────────────────────┬──────┘
          │ Har bir ulanish uchun yangi   │
          ▼ jarayon ochadi (Fork)          ▼
   ┌──────────────┐                 ┌──────────────┐
   │ Backend Proc │                 │ Backend Proc │
   └──────┬───────┘                 └──────┬───────┘
          │                                │
          └───────────────┬────────────────┘
                          ▼
   ┌──────────────────────────────────────────────┐
   │          SHARED MEMORY (Umumiy RAM)          │
   │  - Shared Buffers (Kesh)                     │
   │  - WAL Buffers (Tranzaksiya xotirasi)        │
   └──────────────────────┬───────────────────────┘
                          │
     Yadro Fon Jarayonlari (Background Workers):
     - checkpointer  (Xotiradagi ma'lumotni diskka tushiruvchi)
     - walwriter     (Tranzaksiyani WAL fayliga yozuvchi)
     - autovacuum    (O'chirilgan ma'lumotlar o'rnini tozalovchi)
                          │
                          ▼
   ┌──────────────────────────────────────────────┐
   │             DISK SAQLAGICHI (PGDATA)         │
   │  - base/   (Haqiqiy jadvallar va indekslar)  │
   │  - pg_wal/ (Write-Ahead Log jurnallari)      │
   └──────────────────────────────────────────────┘
```

### Muhim jarayonlar (Processes):
1. **Postmaster (Bosh jarayon):** Yangi ulanishlarni (TCP yoki Unix Socket orqali) qabul qiladi va har bir yangi mijoz uchun alohida backend worker jarayonini ishga tushiradi (`fork`).
2. **walwriter:** ACID talablariga ko'ra har bir yozilgan tranzaksiyani birinchi bo'lib WAL jurnaliga tezkor saqlaydi.
3. **checkpointer:** Vaqti-vaqti bilan RAM'dagi o'zgartirilgan ma'lumotlarni haqiqiy disk jadvallariga (flush) yozadi.
4. **autovacuum:** PostgreSQL'da `UPDATE` yoki `DELETE` bo'lganda qadimgi qator darhol o'chmaydi (dead tuple bo'lib qoladi). Autovacuum diskni tozalab, bo'sh joyni qaytaradi.

---

## 📂 2-Qism: Saqlash Qatlami (`PGDATA`)

PostgreSQL barcha ma'lumotlarini bitta katalogda saqlaydi (odatda `/var/lib/postgres/data`):
* **`base/`** — Barcha ma'lumotlar bazalari, jadvallari va indekslari joylashgan katalog.
* **`pg_wal/`** — Write-Ahead Logging (WAL) jurnallari. Baza to'satdan o'chib qolsa yoki elektr uzilsa, tranzaksiyalar aynan shu jurnaldan qayta tiklanadi.
* **`postgresql.conf`** — Asosiy server sozlamalari (port, xotira, tarmoq).
* **`pg_hba.conf`** — Tarmoq xavfsizligi va autentifikatsiya siyosati.

---

## 🛡️ 3-Qism: Xavfsizlik va Tarmoq Konfiguratsiyasi

### 1. `postgresql.conf` (Tizim darajasidagi sozlamalar)
* `listen_addresses = 'localhost'` (Faqat lokal ulanishlar uchun) yoki `'*'` (Barcha tashqi tarmoqlar uchun).
* `port = 5432` (yoki maxsus o'rnatilgan port, masalan: `5433`).
* `max_connections = 100` (Bir vaqtda qancha mijoz ulana olishi).

### 2. `pg_hba.conf` (Host-Based Authentication)
Bu fayl — PostgreSQL'ning eng asosiy xavfsizlik filtri. Har qanday ulanish uchun ushbu jadval yuqoridan pastga qarab tekshiriladi.

Har bir qator 5 ta ustundan iborat:
```text
# TYPE    DATABASE        USER            ADDRESS            METHOD
local     all             all                                peer
host      all             all             127.0.0.1/32       scram-sha-256
host      paypulse_prod   paypulse_api    10.0.0.0/16        scram-sha-256
```

* **TYPE:**
  * `local` — Unix domain socket orqali (serverning o'zidan).
  * `host` — TCP/IP tarmog'i orqali (lokal yoki tashqaridan).
* **DATABASE:** Qaysi bazaga (`all`, yoki aniq baza nomi: `paypulse_prod`).
* **USER:** Qaysi foydalanuvchiga (`all`, yoki `paypulse_api`).
* **ADDRESS:** Qaysi IP yoki CIDR subnetdan ruxsat berilgan (`127.0.0.1/32`, `10.0.0.0/16`).
* **METHOD (Autentifikatsiya usuli):**
  * `scram-sha-256` / `md5` — Parol bilan shifrlangan ulanish (Eng xavfsiz va standart).
  * `peer` — Linux tizimidagi login PostgreSQL foydalanuvchisi bilan bir xil bo'lishini talab qiladi (faqat lokal socket).
  * `trust` — **ENG XAVFLI USUL!** Parolsiz har kimga to'liq ruxsat beradi. Ishlab chiqarishda (Production) qat'iyan taqiqlangan!

---

## 👥 4-Qism: Rollar va Ruxsatlar (Least Privilege Prinsipi)

DevOps va xavfsizlikning oltin qoidasi:
> ❌ **HECH QACHON** dasturlarga (Backend API, Microservices) `postgres` superuser hisobini bermang!

Agar bitta mikroxizmat buzilsa, xaker butun ma'lumotlar bazasini o'chirib tashlay olmasligi kerak.

### To'g'ri arxitektura:
1. **Foydalanuvchi yaratish (LOGIN va Parol bilan):**
   ```sql
   CREATE ROLE paypulse_api WITH LOGIN PASSWORD 'MaxfiyParol123!';
   ```
2. **Bazaga ulanish huquqini berish:**
   ```sql
   GRANT CONNECT ON DATABASE paypulse_prod TO paypulse_api;
   ```
3. **Faqat kerakli jadvallarga kerakli huquqni berish:**
   ```sql
   -- Faqat tranzaksiyalar va foydalanuvchilar jadvaliga o'qish/yozish huquqi:
   GRANT SELECT, INSERT, UPDATE ON TABLE transactions, customers TO paypulse_api;

   -- Muhim maxfiy jadval (audit_secrets)ga huquq BERILMAYDI!
   ```

---

## 💾 5-Qism: Zaxiralash va Tiklash (Backup & Disaster Recovery)

SRE va DevOps muhandisining eng muhim vazifasi — ma'lumotlar yo'qolishining oldini olish.

### 1. Mantiqiy Zaxiralash (`pg_dump`):
Baza jadvallari va yozuvlarini SQL yoki siqilgan ikkilik faylga eksport qilish:
```bash
# Custom formatda (-Fc) siqib olish (Eng tez va xavfsiz usul):
pg_dump -h localhost -p 5433 -U sanjar -Fc paypulse_prod > /path/to/backup.dump

# SQL matn shaklida olish:
pg_dump -h localhost -p 5433 -U sanjar paypulse_prod > backup.sql
```

### 2. Tiklash (`pg_restore` va `psql`):
```bash
# Custom formatdagi dump fayldan yangi bazaga tiklash:
pg_restore -h localhost -p 5433 -U sanjar -d yangi_baza /path/to/backup.dump

# SQL matn fayldan tiklash:
psql -h localhost -p 5433 -U sanjar -d yangi_baza -f backup.sql
```

---

## 🩺 6-Qism: Diagnostika va Monitoring (SRE Cheat-Sheet)

Production bazasi qotib qolsa yoki so'rovlar tiqilib qolsa:

### 1. Faol ulanishlar va so'rovlarni ko'rish:
```sql
SELECT pid, usename, client_addr, state, query_start, query 
FROM pg_stat_activity 
WHERE state != 'idle';
```

### 2. Qotib qolgan yoki xalaqit berayotgan so'rovni o'chirish:
```sql
-- Yumshoq to'xtatish (Cancel query):
SELECT pg_cancel_backend(1234);

-- Majburiy ulanishni uzish (Kill process):
SELECT pg_terminate_backend(1234);
```

### 3. Baza va jadvallar hajmini aniqlash:
```sql
-- Bazaning diskdagi umumiy hajmi:
SELECT pg_size_pretty(pg_database_size('paypulse_prod'));

-- Eng katta jadvallar ro'yxati:
SELECT relname, pg_size_pretty(pg_total_relation_size(relid)) 
FROM pg_catalog.pg_statio_user_tables 
ORDER BY pg_total_relation_size(relid) DESC;
```
