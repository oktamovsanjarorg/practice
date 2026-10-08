# 📘 3-BOSQICH HANDBOOK: FOYDALANUVCHILAR, RUXSATLAR VA MAXSUS BITLAR (PERMISSIONS & SPECIAL BITS)

Linux — ko'p foydalanuvchili (multi-user) operatsion tizim. Xavfsizlikning asosi: **"Kimga nima qilish mumkin va nima taqiqlangan?"** degan qoidaga tayanadi.

Ushbu qo'llanma oddiy ruxsatlar (`chmod`, `chown`) va xavfsizlikning cho'qqisi bo'lgan **Maxsus Bitlar (SUID, SGID, Sticky bit)**ni o'rgatadi.

---

## 🛡️ 1-Qism: Standart Ruxsatlar Arxitekturasi

`ls -l` buyrug'ini berganingizda, chap tomonda 10 ta belgi ko'rinadi:
```
-rwxr-xr--  1 sanjar devops 4096 Oct 5 12:00 deploy.sh
```

Bu 10 ta belgi 4 qismga bo'linadi:
1. **1-belgi (Turi):** `-` (oddiy fayl), `d` (papka), `l` (havola / symlink).
2. **2, 3, 4-belgilar (`u` - User / Egasi):** Fayl egasining huquqi (`rwx`).
3. **5, 6, 7-belgilar (`g` - Group / Guruh):** Guruh a'zolarining huquqi (`r-x`).
4. **8, 9, 10-belgilar (`o` - Others / Boshqalar):** Tizimdagi qolgan barcha begonalarning huquqi (`r--`).

### Raqamli qiymatlar (Oktal sonlar):
* **`r` (Read / O'qish)** = **4**
* **`w` (Write / Yozish, o'zgartirish, o'chirish)** = **2**
* **`x` (Execute / Ishga tushirish)** = **1**

| Raqam | Belgisi | Ma'nosi | Qayerda ishlatiladi? |
| :---: | :--- | :--- | :--- |
| **`755`** | `rwxr-xr-x` | Egasi hamma narsa qila oladi, qolganlar faqat o'qiydi va ishga tushiradi | Skriptlar, dasturlar, ochiq papkalar |
| **`644`** | `rw-r--r--` | Egasi o'qiydi/yozadi, qolganlar faqat o'qiydi | Oddiy matnli fayllar, configlar |
| **`600`** | `rw-------` | Faqat egasi o'qiydi va yozadi, boshqalarga mutlaqo yopiq | SSH kalitlar (`id_rsa`), maxfiy parollar, backup |
| **`700`** | `rwx------` | Faqat egasiga ochiq bo'lgan shaxsiy papka | Shaxsiy kataloglar |

> **Muhim noziklik (Papkalarda `x` nima?):**  
> Fayllarda `x` — dasturni ishga tushirish.  
> Papkalarda `x` — **papkaning ichiga kirish (`cd`) huquqi**! Agar papkaga `r` bo'lsa-yu, `x` bo'lmasa, siz uning ichidagi fayllarni ocholmaysiz!

---

## 👑 2-Qism: Egalikni O'zgartirish (`chown` va `chgrp`)

Fayl yoki papkaning egasini va guruhini o'zgartirish:
```bash
# Egasini o'zgartirish:
sudo chown sanjar fayl.txt

# Egasi va guruhini birga o'zgartirish:
sudo chown sanjar:devops fayl.txt

# Butun papka va uning ichidagilar bilan rekursiv (-R):
sudo chown -R sanjar:devops /manzil/papka
```

---

## 🔥 3-Qism: Maxsus Bitlar (Special Bits - Senior DevOps Sirlari)

Standart `rwx` ba'zi jamoaviy va xavfsizlik muammolarini yecha olmaydi. Shu sababli Linux'da 3 ta maxsus bit bor:

### 1. `SGID` (Set Group ID - Qiymati: `2000` yoki `g+s`)
* **Qayerga qo'yiladi:** Jamoaviy papkalarga (`chmod 2775 /shared_folder` yoki `chmod g+s ...`).
* **Nima qiladi? (Mental model):**  
  Odatda biror papkada yangi fayl ochsangiz, uning guruhi sizning asosiy guruhingiz bo'lib qoladi.  
  Lekin papkada **`SGID`** yoqilgan bo'lsa — bu papka ichida kim yangi fayl ochmasin, yangi faylning guruhi **avtomatik ravishda ushbu papkaning guruhiga aylanadi**!  
  *(Jamoada bir necha injenerlar bitta papkada ishlaganda xatolar chiqmasligi uchun shart).*

### 2. `Sticky Bit` (Qiymati: `1000` yoki `+t`)
* **Qayerga qo'yiladi:** Umumiy axlatxona / vaqtinchalik papkalarga (`chmod 1777 /dropzone` yoki `chmod +t ...`).
* **Nima qiladi? (Mental model):**  
  Papkaga hamma yoza oladi (`777`), lekin **birovning faylini faqat o'sha faylning o'z egasi yoki root o'chira oladi**! Boshqalar birovning faylini o'chira olmaydi.  
  *(Klassik misol: `/tmp` papkasining huquqi aynan `1777` ya'ni `drwxrwxrwt`).*

### 3. `SUID` (Set User ID - Qiymati: `4000` yoki `u+s`)
* **Qayerga qo'yiladi:** Binar dasturlarga (`chmod u+s /fayl`).
* **Nima qiladi?** Dastur kim tomonidan ishga tushirilmasin, u o'zining **haqiqiy egasining (ko'pincha root) huquqi bilan** ishlaydi.  
  *(Masalan: `/usr/bin/passwd` dasturida SUID bor, shuning uchun oddiy user ham o'z parolini o'zgartirganda `/etc/shadow`ga yoza oladi).*
* **Xavfsizlik tekshiruvi:** Tizimda xavfli SUID fayllarni topish:
  ```bash
  find / -perm -4000 2>/dev/null
  ```
  Zararsizlantirish (SUID ni olib tashlash): `chmod u-s /fayl`
