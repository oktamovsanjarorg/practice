# 📘 2-BOSQICH HANDBOOK: I/O REDIRECTION, OQIMLAR VA QUVURLAR (PIPES)

Linux arxitekturasining eng go'zal qonunlaridan biri: **"Kichik dasturlar yoz va ularni bir-biriga quvurlar orqali ula"** (Unix Philosophy).

Dasturlarning ma'lumotlarini qayerga yo'naltirish va xatolarni qanday ajratishni bilish — DevOps'da loglarni boshqarishning 100% asosi hisoblanadi.

---

## 🌊 1-Qism: 3 ta Standart Oqim (File Descriptors)

Linux'da har qanday dastur ishga tushganda, unga avtomatik tarzda **3 ta kanal (oqim)** biriktiriladi:

| Raqam | Nomi | To'liq nomi | Oddiy holatda qayerga ulangan? |
| :---: | :--- | :--- | :--- |
| **`0`** | **`stdin`** | *Standard Input* | Klaviaturaga (siz kiritayotgan matn). |
| **`1`** | **`stdout`** | *Standard Output* | Monitorga (dasturning to'g'ri natijasi). |
| **`2`** | **`stderr`** | *Standard Error* | Monitorga (dastur yuzaga keltirgan xatolar). |

> **Muhim tushuncha:** Terminalda `stdout` va `stderr` ikkalasi ham ko'zingizga bir xil matn bo'lib ko'rinadi. Lekin Linux uchun ular **ikki xil quvur**! Siz ularni istalgan tomonga alohida yo'naltira olasiz.

---

## 🔀 2-Qism: Qayta Yo'naltirish Operatorlari (Redirection)

### 1. Natijani (stdout) yo'naltirish:
* **`>`** — Faylga yozish (agar fayl bo'lsa, **ichidagilarni o'chirib, ustidan yozadi**):
  ```bash
  echo "Salom" > salom.txt
  ```
* **`>>`** — Faylning **oxiriga qo'shish** (avvalgisini o'chirmaydi):
  ```bash
  echo "Yana salom" >> salom.txt
  ```

### 2. Xatoliklarni (stderr) yo'naltirish:
* **`2>`** — Faqat xatoliklarni faylga yozish:
  ```bash
  ls /mavjud_bolmagan_joy 2> xatolar.log
  ```

### 3. Ikkala oqimni bir vaqtda ajratish:
Natijalarni alohida, xatolarni esa alohida faylga ajratish:
```bash
./mening_dasturim > success.log 2> error.log
```

### 4. Oqimlarni birlashtirish (`2>&1` va `&>`):
Xatolar ham natijalar bilan bitta faylga aralashib tushsin desangiz:
```bash
./mening_dasturim > barchasi.log 2>&1
# yoki zamonaviy qisqartmasi:
./mening_dasturim &> barchasi.log
```

### 5. Qora tuynuk (`/dev/null`):
Hech qanday xatolik ham, xabar ham ko'rinmasin, jim-jit bo'lsin:
```bash
./dastur > /dev/null 2>&1
```

---

## 🚰 3-Qism: Quvurlar (`|` Pipes) va Matn Filtratorlari

Quvur (`|` - vertikal chiziq) — chapdagi dasturning **`stdout`** chiqishini o'ngdagi dasturning **`stdin`** kirishiga to'g'ridan-to'g'ri ulab beradi.

### Asosiy quvur zanjirlari:
* **`sort`** — Qatorlarni alifbo bo'yicha saralaydi.
* **`uniq -c`** — Bir xil qatorlarni sanab chiqadi (Masalan: `3 [ERROR] DB_TIMEOUT`).  
  *(DIQQAT: `uniq` ishlashi uchun avval qatorlar `sort` qilingan bo'lishi shart!).*
* **`grep`** — Matn ichidan aniq qatorlarni filtrlaydi.
* **`wc -l`** — Qatorlar sonini sanaydi.
* **`tee`** — Oqimni ikkiga bo'ladi: bir vaqtning o'zida ham ekranga chiqaradi, ham faylga yozadi:
  ```bash
  ./dastur | tee oqim.log
  ```
