# 📘 1-BOSQICH HANDBOOK: FAYL TIZIMI (FHS), QIDIRUV VA HAVOLALAR (LINKS)

Ushbu qo'llanma 1-bosqichdagi nosozliklarni mustaqil tahlil qilish va tizimni tuzatish uchun zarur bo'lgan barcha qurollarni beradi.

---

## 🏛️ 1-Qism: Linux Filesystem Hierarchy Standard (FHS)

Linux'da barcha fayllar yagona ildiz (`/` - Root)dan boshlanadi. Har bir katalogning o'z qat'iy maqsadi bor:

* **`/etc` (Editable Text Configs):** Tizim va xizmatlarning barcha **sozlama (konfiguratsiya)** fayllari shu yerda bo'ladi.
* **`/var` (Variable Data):** Dinamik o'zgaruvchi ma'lumotlar. Ayniqsa **`/var/log`** — barcha dasturlar o'z xatolari va faoliyat jurnallarini (log) yozadigan asosiy joy.
* **`/tmp` (Temporary):** Har kim yozishi mumkin bo'lgan vaqtinchalik fayllar.
* **`/proc` (Virtual Filesystem - VFS):** Qattiq diskda emas, bevosita **RAM (operativ xotira)**da yashaydigan virtual oyna. Linux yadrosi (Kernel) o'z holatini shu yerda ko'rsatadi:
  * `/proc/meminfo` — Xotira (RAM) holati va hajmi.
  * `/proc/cpuinfo` — Protsessor yadrolari va modeli.
  * `/proc/version` — Linux yadrosi versiyasi.

---

## 🔗 2-Qism: Inode va Havolalar (Hard Link vs Soft/Symbolic Link)

Linux'da fayl nomi va uning diskdagi haqiqiy ma'lumotlari alohida narsalar hisoblanadi.

### Inode nima?
* **Inode (Index Node):** Faylning tizimdagi "pasporti". Unda faylning hajmi, egasi, ruxsatlari va diskdagi qaysi bloklarda yotgani yoziladi (lekin fayl nomi yozilmaydi).
* Faylning Inode raqamini ko'rish:
  ```bash
  ls -i fayl.txt
  ```

### 1. Symbolic Link (Soft Link / Yarlik)
* Windows'dagi "Yarlik (Shortcut)" kabi ishlaydi. U shunchaki boshqa bir fayl manzilini ko'rsatib turuvchi ko'rsatkich.
* **Yaratish sintaksisi:**
  ```bash
  ln -s <asl_fayl_manzili> <havola_nomi>
  ```
* **Buzilgan havola (Broken Symlink):**
  Agar havola ko'rsatayotgan asl fayl o'chib ketsa yoki ko'chirilsa, havola "buziladi" (`ls -l` da qizil rangda miltillab turadi).
* **Havolani yangilash / to'g'irlash:**
  Eski buzuq havolani yangi to'g'ri manzilga qayta yo'naltirish uchun `-f` (force) qo'shiladi:
  ```bash
  ln -sf <yangi_togri_manzil> <mavjud_havola>
  ```
* **Havola qayerga ko'rsatayotganini ko'rish:**
  ```bash
  readlink /manzil/havola
  ```

---

## 🔍 3-Qism: Tergov va Qidiruv Qurollari

* **Faylni nomi bo'yicha qidirish (`find`):**
  ```bash
  find /etc -name "*.conf" 2>/dev/null
  ```
* **Buzilgan havolalarni (Broken symlinks) topish:**
  ```bash
  find /etc -xtype l 2>/dev/null
  ```
* **Matn ichidan qidirish (`grep`):**
  ```bash
  grep -rni "xato_so'zi" /var/log/ 2>/dev/null
  ```
* **Fayl turini aniqlash (`file`):**
  ```bash
  file /manzil/fayl
  ```
