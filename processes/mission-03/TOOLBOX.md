# 🧰 LINUX SIGNALLARI VA JARAYON BOSHQARUVI TOOLBOX

Linux yadrosi (Kernel) jarayonlar bilan muloqot qilish uchun **Signallar (Signals)**dan foydalanadi.
Har bir signalning o'z raqami, nomi va maxsus vazifasi bor.

---

### 1. Eng muhim signallar jadvali

| Raqam | Nomi | Vazifasi (Nima qiladi?) | Qachon ishlatiladi? |
| :---: | :--- | :--- | :--- |
| **`1`** | **`SIGHUP`** | *Hangup / Reload* | Xizmatni to'xtatmasdan (0 sekund uzilishsiz) uning yangi konfiguratsiyasini qayta o'qitish. Nginx va databaselar shunday yangilanadi. |
| **`15`** | **`SIGTERM`** | *Terminate (Graceful)* | Jarayonga: "Ishingni chiroyli yakunla, fayllarni saqla va yopil" degan odobli signal. Standart `kill <PID>` aynan shu signalni yuboradi. |
| **`9`** | **`SIGKILL`** | *Kill (Shafqatsiz)* | Jarayonning o'ziga xabar berilmaydi, yadro uni zudlik bilan yo'q qiladi. Buferlar tozalanmaydi, lock fayllar qolib ketadi va ma'lumot buziladi. |
| **`19`** | **`SIGSTOP`** | *Stop / Freeze* | Jarayonni muzlatib, xotirada to'xtatib qo'yish (pauza). |
| **`18`** | **`SIGCONT`** | *Continue* | Muzlatilgan (pauzadagi) jarayonni qayta uyg'otish va ishini davom ettirish. |

---

### 2. Signallarni yuborish sintaksisi

Signal nom bilan yoki raqam bilan yuboriladi:
```bash
kill -HUP <PID>      # yoki: kill -1 <PID>
kill -CONT <PID>     # yoki: kill -18 <PID>
kill -TERM <PID>     # yoki: kill -15 <PID>
kill -9 <PID>        # Favqulodda majburiy o'ldirish
```

---

### 3. Jarayon holatlari (`ps aux` dagi `STAT` ustuni)

`ps aux` buyrug'ini berganingizda, `STAT` ustunidagi harflar jarayonning tiriklik holatini bildiradi:
* **`R` (Running):** Hozir protsessorda faol ishlayotgan jarayon.
* **`S` (Sleeping):** O'z navbatini kutib uxlayotgan jarayon.
* **`T` (Stopped / Paused):** Signal (`SIGSTOP`) bilan muzlatib qo'yilgan jarayon.
* **`Z` (Zombie):** Vafot etgan, lekin otasi uni xotiradan ro'yxatdan o'chirmagan o'lik jarayon.

---

### 4. Tergovchi buyrug'i: Loglarni real vaqtda kuzatish
Tizim nima qilayotganini va signallarga qanday javob berayotganini jonli ko'rish:
```bash
tail -f engine.log
```
*(Chiqish uchun: `Ctrl + C`)*
