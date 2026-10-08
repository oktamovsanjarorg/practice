# 🎫 JIRA TICKET: PAYPULSE-402

**Project:** PayPulse Infrastructure & Core Banking  
**Key:** PAYPULSE-402  
**Priority:** 🔴 P1 - Blocker  
**Reporter:** Lead SRE & DBA Architecture  
**Assignee:** Sanjar (Cloud & DevOps Engineer)  
**Status:** In Progress  

---

## 📌 Muammo Tavsifi

Salom Sanjar,  
Bugun tongda monitoring tizimi va FinTech xavfsizlik guruhi serverda ikkita jiddiy saqlash (storage) muammosini qayd etdi:

### 💥 1-Xatolik: Tranzaksiya Dvigateli Xotirasi Izolyatsiyasi (Core DB Mount)
* **Alomat:** `./paypulse-db/start_engine.sh` ishga tushmayapti.
* **Sabab:** Tranzaksiyalar xavfsizligi qoidasiga binoan, moliyaviy yozuvlar OS root bo'limiga emas, alohida ajratilgan xotira hajmiga (`/mnt/paypulse_data`) yozilishi shart. Hozirda bu joyga alohida disk ulanmagan.
* **Qilinishi kerak:**
  1. Kamida 200MB hajmga ega bo'lgan disk obrazini yarating (masalan, `paypulse_data.img`).
  2. Uni `ext4` fayl tizimida formatlang.
  3. `/mnt/paypulse_data` ulanish nuqtasiga (mount point) ulang.
  4. Mount qilinganidan keyin dastur yozishi uchun katalog egaligi va ruxsatlarini to'g'irlang (*Eslatma: Mount qilingach katalog egasi root bo'lib qolishi mumkin*).
  5. `./paypulse-db/start_engine.sh` ni ishga tushiring — u faol holatga o'tishi shart.

---

### 💥 2-Xatolik: Audit Xizmati Yiqilishi — "No space left on device" (Inode Mystery)
* **Alomat:** `./paypulse-audit/run_audit.sh` xizmati yiqilmoqda:  
  `[CRITICAL ENOSPC ERROR] No space left on device: '/mnt/paypulse_audit/compliance_2026.log'`
* **G'alati holat:** Navbatchi junior admin xabar qildi:  
  *"Men `df -h /mnt/paypulse_audit` qilib ko'rdim, u yerda 22MB bo'sh joy turibdi-ku! Nega tizim bo'sh joy yo'q deb xato beryapti?!"*
* **Qilinishi kerak:**
  1. Muammoning asl sababini aniqlang (Disk hajmidan tashqari Inodlar bandligini tekshiring).
  2. Qaysi papkada keraksiz bo'sh fayllar to'planib Inodlarni yeb yuborganini toping va ularni tozalang. (*Ehtiyot bo'ling: `compliance_policy.json` kabi haqiqiy audit fayllariga tegmang!*)
  3. Inodlar bo'shatilgach, `./paypulse-audit/run_audit.sh` ni qayta ishga tushiring — audit hisoboti muvaffaqiyatli saqlanishi kerak.

---

## 🛠️ Diagnostika va Tekshirish Vositalari

* Nazariy mental model: `cat HANDBOOK.md`
* Joriy xotira holatini ko'rish: `./simulate.sh`
* SRE yakuniy tekshiruvi: `./verify.sh`
