# 🧰 JARAYONLAR (PROCESSES) TOOLBOX

Ushbu qo'llanma jarayonlarni tekshirish uchun asosiy qurollarni o'z ichiga oladi.

---

### 1. `ps -ef` (Tavsiya etiladi)
Tizimdagi barcha jarayonlarni jadval ko'rinishida chiqaradi.
* **Ustunlar:**
  * `UID`  — Jarayon egasi
  * `PID`  — Jarayonning shaxsiy raqami (Process ID)
  * `PPID` — Ushbu jarayonni ishga tushirgan **OTA JARAYON** raqami (Parent PID)
  * `CMD`  — Jarayonni ishga tushirgan buyruq nomi

* **Qidirish uchun:**
  ```bash
  ps -ef | grep secret-agent
  ```

---

### 2. `pgrep` (Tezkor qidiruv)
Jarayon nomidan faqat uning PID raqamini topib beradi.
* **Foydalanish:**
  ```bash
  pgrep -l secret-agent    # -l: nomi bilan birga chiqaradi
  ```

---

### 3. `pstree -p` (Oila daraxti)
Jarayonlarni shoxma-shox, kim kimdan tug'ilganini ko'rsatadi.
* **Foydalanish:**
  ```bash
  pstree -p <PID_RAQAMI>   # Berilgan PID va uning bolalarini daraxt qilib ko'rsatadi
  ```
  yoki:
  ```bash
  pstree -pa $USER         # Sizning barcha jarayonlaringiz daraxti
  ```
