# 📘 4-BOSQICH HANDBOOK: BLOK QURILMALAR, FAYL TIZIMI VA MOUNT ARXITEKTURASI (STORAGE & FILESYSTEMS)

Linux tizimlarida ma'lumotlarni saqlash arxitekturasi Windows tizimlaridagidek disk harflari (`C:`, `D:`) bilan emas, balki **yagona VFS (Virtual File System) daraxti** va **blok qurilmalar** vositasida tashkil etiladi.

Ushbu qo'llanma Cloud muhandisi va Senior DevOps mutaxassislari bilishi shart bo'lgan saqlash arxitekturasi, formatlash, Inode mental modeli hamda xatoliklarni bartaraf etish (troubleshooting) sirlarini o'rgatadi.

---

## 💽 1-Qism: Blok Qurilmalar (Block Devices) Mental Modeli

Linux barcha qurilmalarni fayl sifatida ko'radi (`/dev` katalogi). Qurilmalar ikki asosiy turga bo'linadi:
1. **Character Devices (Belgili qurilmalar):** Ma'lumot baytma-bayt ketma-ket oqim shaklida o'qiladi/yoziladi (masalan: `/dev/tty`, `/dev/urandom`).
2. **Block Devices (Blok qurilmalar):** Ma'lumot qat'iy belgilangan hajmdagi bloklarda (odatda 512 bayt yoki 4096 bayt) saqlanadi va ixtiyoriy joyiga (random access) to'g'ridan-to'g'ri murojaat qilinadi.

### Asosiy blok qurilma nomlari:
* `/dev/sda`, `/dev/sdb` — SCSI, SATA yoki Cloud virtual disklari (AWS EBS / GCP Persistent Disk).
* `/dev/nvme0n1` — Zamonaviy tezkor NVMe SSD disklari (`nvme0n1p1` — 1-partitsiya).
* `/dev/loop0`, `/dev/loop1` — **Loop qurilmalari** (oddiy faylni operatsion tizimga disk sifatida ko'rsatish vositasi).

### Diagnostika vositalari:
```bash
# Blok qurilmalar ierarxiyasini daraxt shaklida ko'rish:
lsblk

# Blok qurilmalarning UUID va fayl tizimi turini ko'rish:
lsblk -f
blkid
```

---

## 🧩 2-Qism: Fayl Tizimi (Filesystem) va Formatlash

Xom disk (raw block device) — bu shunchaki 0 va 1 lardan iborat xom baytlar qatori. Unga fayllar, papkalar va ruxsatlarni saqlash uchun **Fayl Tizimi (Filesystem)** kerak.

### Formatlash nima?
Formatlash — diskda fayllar katalogi, indekslar va bo'sh joylar hisobini yurituvchi maxsus tizimli jadvallarni (Superblock, Inode Table, Block Allocation Map) yozish jarayonidir.

Eng mashhur fayl tizimlari:
* **ext4 (Fourth Extended Filesystem):** Linux olamidagi eng ishonchli, universal va keng tarqalgan fayl tizimi.
* **XFS:** Katta hajmdagi ma'lumotlar va parallel I/O uchun yuqori unumdorlikka ega fayl tizimi (RHEL/CentOS standartida).

Formatlash buyrug'i:
```bash
# Qurilmani ext4 fayl tizimida formatlash:
sudo mkfs.ext4 /dev/sdb1

# Xom disk obrazini to'g'ridan-to'g'ri formatlash:
mkfs.ext4 my_disk.img
```

---

## 🧠 3-Qism: Inode (Index Node) — Senior SRE Mental Modeli

Fayl tizimida har bir fayl ikki narsadan iborat:
1. **Fayl Metadatasi (Inode):** Faylning xususiyatlari.
2. **Fayl Ma'lumoti (Data Blocks):** Fayl ichidagi haqiqiy baytlar.

### Inode ichida nimalar saqlanadi?
* Fayl turi (oddiy fayl, papka, havola)
* Egasi va Guruhi (UID / GID)
* Ruxsatlar (`chmod` huquqlari: `rwxr-xr-x`)
* Vaqt belgilari (atime, mtime, ctime)
* Hajmi (baytlarda)
* Fayl ma'lumotlari qaysi ma'lumot bloklarida saqlangani ko'rsatkichlari (pointers).

> ⚠️ **Muhim sir:** Inode ichida **FAYLNING NOMI SAQLANMAYDI**!  
> Fayl nomi papka (directory entry) ichida `fayl_nomi -> Inode_raqami` xaritasi ko'rinishida saqlanadi.

---

### 🔥 Real Incident: Inode To'lishi (Inode Exhaustion)
Har bir fayl tizimi formatlanganda unda cheklangan miqdorda Inode yacheykalari ajratiladi.

Tasavvur qiling:
* Serverda 100 GB bo'sh disk joyi bor.
* Qaysidir nosoz skript 0 baytli (bo'sh) millionlab vaqtinchalik `.lock` yoki kesh fayllarni yaratdi.
* Diskdagi megabaytlar kamaymadi (chunki fayllar 0 bayt).
* Lekin **barcha Inodlar tugadi**!

**Natija:**
Operatsion tizim barcha dasturlarga:
`OSError: [Errno 28] No space left on device`
xatosini tashlaydi!

Junior muhandis `df -h` ni ochadi va hayron qoladi: *"Diskda 90 GB bo'sh joy turibdi-ku, nega No space left on device deyapti?!"*

**Senior DevOps yechimi:**
```bash
# Disk hajmini tekshirish:
df -h

# Inodlar soni va foizini tekshirish:
df -i

# Qaysi papkada ko'p fayl to'planganini aniqlash:
find /var/log -type f | wc -l
```

---

## 🔄 4-Qism: Loop Qurilmalari (Virtual Disks)

DevOps va konteynerizatsiyada (Docker, Kubernetes containerd) ko'pincha alohida jismoniy qattiq disk bo'lmaydi. Buning o'rniga fayldan virtual disk sifatida foydalaniladi:

1. **Bo'sh disk obrazini yaratish:**
   ```bash
   # 200 Megabaytli bo'sh fayl yaratish:
   fallocate -l 200M storage.img
   # Yoki klassik dd bilan:
   dd if=/dev/zero of=storage.img bs=1M count=200
   ```

2. **Faylni formatlash:**
   ```bash
   mkfs.ext4 storage.img
   ```

3. **Loop qurilma orqali ulash:**
   ```bash
   sudo mount -o loop storage.img /mnt/target
   ```
   Linux yadrosi ushbu faylni avtomatik tarzda bo'sh `/dev/loopX` qurilmasiga ulaydi va katalogga mount qiladi.

---

## 🚪 5-Qism: Mount & Umount — Tizimga Ulanish

Linux'da yangi xotira qurilmasidan foydalanish uchun uni bo'sh katalogga "payvandlash" kerak. Bu katalog **Mount Point (Ulanish nuqtasi)** deyiladi.

```bash
# 1. Mount nuqtasini yaratish:
sudo mkdir -p /mnt/mydata

# 2. Qurilmani ulash:
sudo mount /dev/sdb1 /mnt/mydata

# 3. Faol mountlarni tekshirish:
findmnt /mnt/mydata
```

### 🚨 Eng xatarli Production xatosi: Mount Ruxsatlari (Permissions Gotcha)
Tasavvur qiling, siz `/mnt/mydata` papkasini ochib, unga `chown sanjar:sanjar` qildingiz.
So'ngra `sudo mount /dev/sdb1 /mnt/mydata` qildingiz.
**Nima yuz beradi?**
Yangi formatlangan fayl tizimining ildizi (root-i) mount nuqtasi ustiga tushadi. Uning egasi esa avtomatik tarzda `root:root (755)` bo'ladi!
Oddiy foydalanuvchi yoki dastur (Postgres, Node.js, Python) ushbu katalogga fayl yoza olmaydi (`Permission denied`).

👉 **Oltin Qoida:**  
Mount qilinganidan **KEYIN** mount nuqtasining egasini va ruxsatini to'g'irlash shart:
```bash
sudo mount -o loop storage.img /mnt/mydata
sudo chown -R sanjar:sanjar /mnt/mydata
```

### Qurilmani ajratish (Unmounting):
```bash
sudo umount /mnt/mydata
```
Agar `target is busy` (qurilma band) xatosi chiqsa:
Bu qaysidir jarayon yoki terminal o'sha papka ichida turganini bildiradi.
```bash
# Qaysi jarayon papkadan foydalanayotganini aniqlash:
fuser -m /mnt/mydata
lsof +f -- /mnt/mydata
```

---

## 🔒 6-Qism: Doimiylik (Persistence) va `/etc/fstab`

`mount` buyrug'i bilan ulangan qurilmalar server o'chib yoqilganda (reboot) yo'qoladi. Tizim avtomatik ulashi uchun `/etc/fstab` fayliga yoziladi.

`/etc/fstab` 6 ta ustundan iborat:
```text
<Qurilma / UUID>    <Mount Point>    <FSType>    <Options>    <Dump>    <Pass>
UUID=1234-abcd      /mnt/data        ext4        defaults     0         2
/path/to/img        /mnt/data        ext4        loop,rw      0         0
```

> ⚠️ **Muhim ogohlantirish:** `/etc/fstab` da bitta xato qilsangiz, Linux qayta yuklanganda "Emergency Mode"ga tushib qoladi. Har doim o'zgartirish kiritgach, reboot qilmasdan oldin:
> ```bash
> sudo mount -a
> ```
> buyrug'i bilan xatolik yo'qligini tekshirish shart!

---

## 🛠️ 7-Qism: DevOps Storage Cheat-Sheet

| Maqsad | Buyruq |
| :--- | :--- |
| Disk xotirasi hajmi | `df -h` |
| Inode soni va bandligi | `df -i` |
| Blok qurilmalar daraxti | `lsblk -f` |
| Mount nuqtasini tekshirish | `findmnt <papka>` |
| Papka hajmini ko'rish | `du -sh <papka>` |
| Eng katta papkalarni saralash | `du -sh * \| sort -h` |
| Disk obrazini yaratish | `fallocate -l <hajm> <nom>` |
| ext4 formatlash | `mkfs.ext4 <obraz_yoki_disk>` |
| Loop mount | `sudo mount -o loop <obraz> <papka>` |
| Inodlarni tozalash | `find <papka> -name "*.lock" -delete` |
