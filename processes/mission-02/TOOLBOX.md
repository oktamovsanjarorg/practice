# 🧰 TARMOQ PORTLARI VA JARAYONLAR TOOLBOX

Linux'da har bir tarmoq xizmati (web server, database) ma'lum bir **Port**ga bog'lanadi (bind).
Bitta portda bir vaqtning o'zida faqat **BITTA** jarayon eshita oladi.

Agar port allaqachon band bo'lsa, yangi xizmat:
`[CRITICAL ERROR] Address already in use` xatosi bilan yiqiladi.

Ushbu qo'llanma portni kim o'g'irlab olganini aniqlash qurollarini o'rgatadi.

---

### 1. `lsof -i :PORT` (Eng qulay va mashhur qurol)
"List Open Files" — Linux'da tarmoq soketi ham fayl hisoblanadi.
Aynan siz qidirayotgan portni qaysi dastur va qaysi PID ushlab turganini ko'rsatadi:

```bash
lsof -i :8080
```
* **Chiqadigan muhim ustunlar:**
  * `COMMAND` — dastur nomi (masalan `python3`, `node`)
  * `PID` — o'sha jarayonning pasport raqami!
  * `USER` — qaysi foydalanuvchi nomidan ishlayapti

---

### 2. `ss -tulpn` (Tizimning asosiy tarmoq tahlilchisi)
Zamonaviy Linux'da `netstat` o'rniga kelgan qudratli utilit.
* **Flaglar ma'nosi:**
  * `-t` — TCP portlar
  * `-u` — UDP portlar
  * `-l` — Faqat quloq solib turgan (Listening) portlar
  * `-p` — Qaysi jarayon (Process va PID) ekanligini ko'rsatish
  * `-n` — Portlarni so'z bilan emas, aniq raqam bilan ko'rsatish

```bash
ss -tulpn | grep 8080
```

---

### 3. `fuser` (Tezkor o'qotar)
Aynan shu portdagi PID raqamini darhol topish:
```bash
fuser 8080/tcp
```

---

### 4. Jarayonni to'xtatish (`kill`)
PID raqami aniqlangach, uni to'xtatish:
```bash
kill <PID>         # Odob bilan to'xtatish (SIGTERM - 15)
kill -9 <PID>      # Majburiy zudlik bilan o'ldirish (SIGKILL - 9)
```
