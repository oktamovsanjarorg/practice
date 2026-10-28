# 🚀 MUTLAQ 0 DAN JUNIOR DEVOPS GACHA: MASTER CHECKLIST & ROADMAP

> **Qo‘llanma:** Ushbu ro‘yxat sizni noldan boshlab real kompaniyalarda ishlay oladigan **Junior DevOps Muhandisi** darajasiga olib chiquvchi to‘liq, atomik va amaliy yo‘l xaritasidir. 
> Har bir mavzu, buyruq yoki tushunchani o‘zlashtirganingiz sari katakchani `- [x]` qilib belgilab boring.

---

## 📑 MUNDARIJA
1. [0-BOSQICH: Kompyuter va Tizim Arxitekturasi (Zero Baseline)](#0-bosqich-kompyuter-va-tizim-arxitekturasi-zero-baseline)
2. [1-BOSQICH: Linux Asoslari va Terminal Navigatsiyasi](#1-bosqich-linux-asoslari-va-terminal-navigatsiyasi)
3. [2-BOSQICH: Linux Oqimlari (Streams), Redirection va Quvurlar (Pipes)](#2-bosqich-linux-oqimlari-streams-redirection-va-quvurlar-pipes)
4. [3-BOSQICH: Matn va Ma'lumotlarni Filtrlash (Text Processing)](#3-bosqich-matn-va-malumotlarni-filtrlash-text-processing)
5. [4-BOSQICH: Foydalanuvchilar, Guruhlar va Ruxsatlar (Security & Permissions)](#4-bosqich-foydalanuvchilar-guruhlar-va-ruxsatlar-security--permissions)
6. [5-BOSQICH: Jarayonlar (Processes) va Tizim Monitoringi](#5-bosqich-jarayonlar-processes-va-tizim-monitoringi)
7. [6-BOSQICH: Disk, Fayl Tizimi va Saqlash (Storage & Filesystems)](#6-bosqich-disk-fayl-tizimi-va-saqlash-storage--filesystems)
8. [7-BOSQICH: Paketlar Boshqaruvi va Arxivlash](#7-bosqich-paketlar-boshqaruvi-va-arxivlash)
9. [8-BOSQICH: Systemd, Xizmatlar (Daemons) va Init](#8-bosqich-systemd-xizmatlar-daemons-va-init)
10. [9-BOSQICH: Tarmoq Asoslari (Networking for DevOps)](#9-bosqich-tarmoq-asoslari-networking-for-devops)
11. [10-BOSQICH: Tarmoq Diagnostikasi va Xavfsizlik Devorlari (Firewalls)](#10-bosqich-tarmoq-diagnostikasi-va-xavfsizlik-devorlari-firewalls)
12. [11-BOSQICH: SSH va Masofaviy Boshqaruv](#11-bosqich-ssh-va-masofaviy-boshqaruv)
13. [12-BOSQICH: Git va Versiyalarni Boshqarish (VCS)](#12-bosqich-git-va-versiyalarni-boshqarish-vcs)
14. [13-BOSQICH: Bash Scripting va Avtomatlashtirish](#13-bosqich-bash-scripting-va-avtomatlashtirish)
15. [14-BOSQICH: Python (DevOps uchun Amaliyot)](#14-bosqich-python-devops-uchun-amaliyot)
16. [15-BOSQICH: Docker va Konteynerizatsiya](#15-bosqich-docker-va-konteynerizatsiya)
17. [16-BOSQICH: Veb-Serverlar va Reverse Proxy (Nginx & Caddy)](#16-bosqich-veb-serverlar-va-reverse-proxy-nginx--caddy)
18. [17-BOSQICH: CI/CD Pipeline (GitHub Actions)](#17-bosqich-cicd-pipeline-github-actions)
19. [18-BOSQICH: Cloud Infratuzilma (AWS)](#18-bosqich-cloud-infratuzilma-aws)
20. [19-BOSQICH: Infratuzilma Kod Sifatida (Terraform - IaC)](#19-bosqich-infratuzilma-kod-sifatida-terraform---iac)
21. [20-BOSQICH: Konfiguratsiya Boshqaruvi (Ansible)](#20-bosqich-konfiguratsiya-boshqaruvi-ansible)
22. [21-BOSQICH: Kubernetes (K8s) Asoslari](#21-bosqich-kubernetes-k8s-asoslari)
23. [22-BOSQICH: Monitoring, Logging va Incident Management](#22-bosqich-monitoring-logging-va-incident-management)

---

## 0-BOSQICH: Kompyuter va Tizim Arxitekturasi (Zero Baseline)
- [ ] Kompyuter apparat ta'minoti (Hardware): CPU, RAM, Disk (HDD vs SSD vs NVMe) o‘zaro qanday ma'lumot almashadi.
- [ ] Xotira ierarxiyasi (Registers ➔ L1/L2/L3 Cache ➔ RAM ➔ Disk) va ularning tezlik farqi.
- [ ] CPU arxitekturasi: Core, Thread, vCPU (Virtual CPU) tushunchalari.
- [ ] x86_64 (Intel/AMD) va ARM64 (Apple Silicon, AWS Graviton) farqi.
- [ ] BIOS va UEFI tushunchasi.
- [ ] Kompyuterning yuklanish jarayoni (Bootstrapping): Power On ➔ BIOS/UEFI ➔ Bootloader (GRUB) ➔ Linux Kernel ➔ Systemd (PID 1).
- [ ] Kernel Space (Yadro sohasi) va User Space (Foydalanuvchi dasturlari sohasi) nima?
- [ ] Tizim chaqiruvlari (System Calls / Syscalls) nima va ilovalar kernel bilan qanday gaplashadi.

---

## 1-BOSQICH: Linux Asoslari va Terminal Navigatsiyasi
- [ ] Linux Fayl Tizimi Ierarxiyasi (FHS — Filesystem Hierarchy Standard):
  - [ ] `/` — Root (barcha narsaning ildizi)
  - [ ] `/bin` va `/usr/bin` — Binar ijro etiluvchi dasturlar
  - [ ] `/sbin` va `/usr/sbin` — Tizim ma'muri (root) buyruqlari
  - [ ] `/etc` — Tizim va dasturlar konfiguratsiya fayllari
  - [ ] `/var` — O‘zgaruvchan ma'lumotlar (`/var/log`, `/var/lib`)
  - [ ] `/tmp` — Vaqtinchalik fayllar (rebootda o‘chib ketadi)
  - [ ] `/home` — Oddiy foydalanuvchilarning shaxsiy kataloglari
  - [ ] `/root` — Superuser (root) shaxsiy katalogi
  - [ ] `/dev` — Qurilmalar fayllari (`/dev/sda`, `/dev/null`, `/dev/random`)
  - [ ] `/proc` — Virtual fayl tizimi (jarayonlar va yadro holati)
  - [ ] `/sys` — Qurilmalar va drayverlar haqida yadro ma'lumotlari
  - [ ] `/opt` — Uchinchi tomon dasturlari o‘rnatiladigan joy
- [ ] Terminal navigatsiyasi:
  - [ ] `pwd` — Hozir qaysi katalogda ekanlikni ko‘rish
  - [ ] `cd` — Kataloglararo harakatlanish (`cd ~`, `cd ..`, `cd -`, `cd /`)
  - [ ] Nisbiy yo‘l (Relative path) va Mutlaq yo‘l (Absolute path) farqi
  - [ ] `ls` — Katalog tarkibini ko‘rish
  - [ ] `ls -l` — Kengaytirilgan formatda ko‘rish (ruxsatlar, hajm, sana)
  - [ ] `ls -a` — Yashirin fayllarni (`.` bilan boshlanuvchi) ko‘rish
  - [ ] `ls -lh` — Hajmni odam tushunadigan formatda (KB, MB, GB) ko‘rish
  - [ ] `ls -lt` — Oxirgi o‘zgartirilgan vaqti bo‘yicha tartiblash
  - [ ] `ls -lS` — Hajmi bo‘yicha tartiblash
  - [ ] `ls -laR` — Rekursiv ko‘rish (barcha ichki papkalar bilan)
  - [ ] `ls -i` — Faylning Inode raqamini ko‘rish
- [ ] Fayl va papkalar bilan asosiy amallar:
  - [ ] `touch filename` — Bo‘sh fayl yaratish yoki timestamp yangilash
  - [ ] `mkdir foldername` — Papka yaratish
  - [ ] `mkdir -p path/to/nested/folder` — Ichma-ich papkalar ierarxiyasini birdaniga yaratish
  - [ ] `cp file1 file2` — Fayldan nusxa olish
  - [ ] `cp -r dir1 dir2` — Papkani ichidagi barcha narsalari bilan rekursiv nusxalash
  - [ ] `cp -p` — Ruxsatlar va yaratilgan vaqtini saqlagan holda nusxalash
  - [ ] `mv old_name new_name` — Fayl/papka nomini o‘zgartirish yoki boshqa joyga ko‘chirish
  - [ ] `rm filename` — Faylni o‘chirish
  - [ ] `rm -r foldername` — Papkani rekursiv o‘chirish
  - [ ] `rm -f` — So‘ramasdan majburiy o‘chirish
  - [ ] `rm -rf /` nega xavfli va nima sababdan himoyalanganligi
  - [ ] `file filename` — Faylning haqiqiy turini (MIME type / binar yoki matn) aniqlash
  - [ ] `stat filename` — Faylning batafsil metama'lumotlarini ko‘rish

---

## 2-BOSQICH: Linux Oqimlari (Streams), Redirection va Quvurlar (Pipes)
- [ ] Standart kiritish/chiqarish (Standard I/O Streams):
  - [ ] File Descriptor 0 (`stdin`) — Standart kirish (klaviatura)
  - [ ] File Descriptor 1 (`stdout`) — Standart chiqish (terminal ekrani)
  - [ ] File Descriptor 2 (`stderr`) — Standart xatoliklar chiqishi (terminal ekrani)
- [ ] Yo‘naltirish (Redirection) operatorlari:
  - [ ] `>` — Natijani faylga yozish (mavjud faylni to‘liq o‘chirib ustidan yozadi / overwrite)
  - [ ] `>>` — Natijani faylning oxiriga qo‘shish (append)
  - [ ] `<` — Fayl ichidagi ma'lumotni dasturga `stdin` sifatida berish
  - [ ] `2>` — Faqat xatoliklarni (`stderr`) alohida faylga yo‘naltirish
  - [ ] `2>>` — Xatoliklarni fayl oxiriga qo‘shish
  - [ ] `2>&1` — `stderr`ni `stdout` oqimiga birlashtirish
  - [ ] `&>` yoki `>&` — Ham `stdout`, ham `stderr`ni bitta faylga yozish
  - [ ] `/dev/null` — Linuxning "qora tuynugi" (keraksiz loglarni yo‘qotish)
  - [ ] `command > /dev/null 2>&1` ifodasining qatorma-qator mantiqiy tahlili
- [ ] Quvurlar (Pipes):
  - [ ] `|` (Pipe) operatori nima va u bitta dastur chiqishini ikkinchisining kirishiga qanday uzatadi
  - [ ] `tee` buyrug‘i — Ma'lumotni ham ekranga chiqarish, ham faylga yozish
  - [ ] `tee -a` — Fayl oxiriga qo‘shish
  - [ ] `xargs` buyrug‘i — Standart kiruvchi oqimni boshqa dastur argumentlariga aylantirish
  - [ ] Buyruq almashtirish (Command Substitution): `$(command)` va ```` `command` ````
  - [ ] Jarayonlarni almashtirish (Process Substitution): `<(command)` va `>(command)`

---

## 3-BOSQICH: Matn va Ma'lumotlarni Filtrlash (Text Processing)
- [x] Matn ko‘rish vositalari:
  - [x] `cat` — Kichik fayllarni ekranga chiqarish
  - [x] `cat -n` — Qator raqamlari bilan chiqarish
  - [x] `tac` — Faylni teskari tartibda (pastdan yuqoriga) chiqarish
  - [x] `head -n 20` — Faylning birinchi 20 qatorini ko‘rish
  - [x] `tail -n 20` — Faylning oxirgi 20 qatorini ko‘rish
  - [x] `tail -f /var/log/syslog` — Loglarni real vaqtda jonli kuzatish
  - [x] `tail -F` — Fayl o‘chib qayta yaratilsa ham (logrotate) kuzatishni davom ettirish
  - [x] `less` — Katta fayllarni xotirani to‘ldirmasdan qadamma-qadam o‘qish
  - [x] `less` ichida qidiruv (`/so'z`, `n`, `N`, `G`, `q`)
- [x] Qidiruv va Filtrlash (`grep` oilasi):
  - [x] `grep "pattern" file` — Aniq so‘zni qidirish
  - [x] `grep -i` — Katta-kichik harfni ajratmasdan qidirish (case-insensitive)
  - [x] `grep -v` — Qidirilgan so‘z QATNASHMAGAN qatorlarni chiqarish (inversion)
  - [x] `grep -r` yoki `grep -R` — Papka ichidagi barcha fayllardan rekursiv qidirish
  - [x] `grep -n` — Qator raqamini ko‘rsatish
  - [x] `grep -c` — Mos kelgan qatorlar sonini sanash
  - [x] `grep -l` — Faqat fayl nomlarini chiqarish
  - [x] `grep -E` — Regular Expressions (RegEx) yordamida qidirish
  - [x] `grep -o` — Butun qatorni emas, faqat mos kelgan so‘zning o‘zini chiqarish
- [x] Qayta ishlash va tahrirlash:
  - [x] `wc -l` — Qatorlar sonini sanash
  - [x] `wc -w` — So‘zlar sonini sanash
  - [x] `sort` — Matn qatorlarini alifbo bo‘yicha tartiblash
  - [x] `sort -n` — Sonlar bo‘yicha to‘g‘ri tartiblash (1, 2, 10)
  - [x] `sort -r` — Teskari tartiblash
  - [x] `sort -k` — Aniq ustun bo‘yicha tartiblash
  - [x] `uniq` — Ketma-ket kelgan bir xil qatorlarni tozalash (faqat `sort`dan keyin ishlaydi)
  - [x] `uniq -c` — Har bir takrorlangan qator necha marta uchraganini hisoblash
  - [x] `uniq -d` — Faqat takrorlangan qatorlarni ko‘rsatish
  - [x] `cut -d',' -f1,3` — Delimiter (ajratuvchi) bo‘yicha ustunlarni ajratib olish
  - [x] `tr` — Belgilarni almashtirish yoki o‘chirish (`tr 'a-z' 'A-Z'`, `tr -d '\r'`)
- [x] Murakkab matn qurollari:
  - [x] `sed` asoslari: Matn ichidagi so‘zni almashtirish (`sed 's/old/new/g' file`)
  - [x] `sed -i` — O‘zgarishni to‘g‘ridan-to‘g‘ri faylning o‘ziga saqlash
  - [x] `sed` bilan qatorlarni o‘chirish (`sed '/pattern/d' file`)
  - [x] `awk` asoslari: Ustunlar bilan ishlash (`awk '{print $1, $3}' file`)
  - [x] `awk` da ajratuvchi (delimiter) o‘rnatish: `awk -F':' '{print $1}' /etc/passwd`
  - [x] `awk` shartli filtrlash: `awk '$3 > 100 {print $0}' file`
  - [x] `awk` maxsus o‘zgaruvchilari: `NR` (qator raqami), `NF` (ustunlar soni)

---

## 4-BOSQICH: Foydalanuvchilar, Guruhlar va Ruxsatlar (Security & Permissions)
- [ ] Foydalanuvchilar (Users):
  - [ ] Linuxda foydalanuvchilar turlari: `root` (UID 0), tizim foydalanuvchilari (UID 1-999), oddiy foydalanuvchilar (UID 1000+)
  - [ ] `/etc/passwd` fayli strukturasi (7 ta maydonning har birining ma'nosi)
  - [ ] `/etc/shadow` fayli va parollarni xeshlash (sha512, bcrypt)
  - [ ] `id` — Joriy foydalanuvchining UID va GID raqamlarini ko‘rish
  - [ ] `whoami` — Joriy foydalanuvchi nomini bilish
  - [ ] `useradd -m -s /bin/bash username` — Yangi foydalanuvchi yaratish
  - [ ] `passwd username` — Foydalanuvchi parolini o‘zgartirish
  - [ ] `usermod -aG groupname username` — Foydalanuvchini qo‘shimcha guruhga qo‘shish
  - [ ] `userdel -r username` — Foydalanuvchini barcha fayllari bilan o‘chirish
- [ ] Guruhlar (Groups):
  - [ ] Guruh nima uchun kerak (resurslarga umumiy kirish huquqi)
  - [ ] `/etc/group` fayli strukturasi
  - [ ] `groupadd groupname` va `groupdel groupname`
  - [ ] Primary Group (Asosiy guruh) va Secondary Groups (Qo‘shimcha guruhlar) farqi
- [ ] Fayl Ruxsatlari (Permissions):
  - [ ] Ruxsatlar matritsasi: `User` (u), `Group` (g), `Others` (o)
  - [ ] Ruxsat turlari:
    - [ ] `r` (Read) = 4
    - [ ] `w` (Write) = 2
    - [ ] `x` (Execute) = 1
    - [ ] `-` (None) = 0
  - [ ] Ruxsatlarning fayl va papkalarda farq qilishi:
    - [ ] Papkada `r` nima qiladi (fayllar ro‘yxatini ko‘rish)
    - [ ] Papkada `w` nima qiladi (fayl yaratish/o‘chirish)
    - [ ] Papkada `x` nima qiladi (papkaning ichiga `cd` qilib kirish)
  - [ ] `chmod` — Ruxsatlarni o‘zgartirish:
    - [ ] Sakkizlik sanoq tizimi (Octal): `chmod 755`, `chmod 644`, `chmod 600`, `chmod 700`
    - [ ] Simvolik usul: `chmod u+x`, `chmod g-w`, `chmod o=r`
    - [ ] `chmod -R` — Rekursiv ruxsat berish
    - [ ] Nega `chmod 777` productionda halokatli xato ekanligi
  - [ ] `chown` va `chgrp`:
    - [ ] `chown user:group file` — Egasi va guruhini o‘zgartirish
    - [ ] `chown -R user:group directory` — Rekursiv o‘zgartirish
- [ ] Maxsus ruxsatlar (Special Permissions):
  - [ ] `umask` nima (standart ruxsatlarni hisoblash: 777 - umask yoki 666 - umask)
  - [ ] **SUID (Set User ID — 4000):** Oddiy foydalanuvchi dasturni fayl egasi (root) huquqi bilan yurgizishi (`/usr/bin/passwd` misolida)
  - [ ] **SGID (Set Group ID — 2000):** Papkada yaratilgan barcha yangi fayllar papka guruhini meros qilib olishi
  - [ ] **Sticky Bit (1000):** Faqat fayl egasigina o‘z faylini o‘chira olishi (`/tmp` papkasi misolida)
- [ ] Privilegiya boshqaruvi:
  - [ ] `sudo` mexanizmi va xavfsizligi
  - [ ] `visudo` orqali `/etc/sudoers` faylini xatosiz tahrirlash
  - [ ] `/etc/sudoers.d/` katalogi va parolsiz sudo huquqini sozlash (`NOPASSWD`)
  - [ ] `su - username` (login shell) va `su username` (non-login shell) farqi

---

## 5-BOSQICH: Jarayonlar (Processes) va Tizim Monitoringi
- [ ] Jarayon (Process) tushunchasi:
  - [ ] Jarayon nima va uning hayot sikli (Fork, Exec, Wait, Exit)
  - [ ] `PID` (Process ID) va `PPID` (Parent Process ID)
  - [ ] Zombi jarayonlar (Zombie processes) va Yetim jarayonlar (Orphan processes) nima
  - [ ] `/proc` katalogi ichida har bir jarayon ma'lumotlarini o‘rganish (`/proc/$PID/status`, `/proc/$PID/cmdline`)
- [ ] Jarayonlarni ko‘rish va tahlil qilish:
  - [ ] `ps aux` — Barcha foydalanuvchilarning barcha jarayonlarini ko‘rish
  - [ ] `ps -ef` — Standart formatda ko‘rish
  - [ ] `pstree` — Jarayonlar daraxtini vizual ko‘rish
  - [ ] `pgrep process_name` — Nom bo‘yicha PID topish
  - [ ] `pidof process_name`
  - [ ] `top` buyrug‘i interfeysi va metrikalari
  - [ ] `htop` — Qulay va rangli jarayonlar menejeri
- [ ] Signallar (Signals) va jarayonlarni to‘xtatish:
  - [ ] Linux signallari nima va ular jarayonga qanday yetkaziladi
  - [ ] `SIGTERM` (Signal 15) — Madaniyatli to‘xtatish (Graceful shutdown)
  - [ ] `SIGKILL` (Signal 9) — Majburiy va darhol o‘ldirish (resurslarni tozalashga ulgurmaydi)
  - [ ] `SIGHUP` (Signal 1) — Konfiguratsiyani qayta yuklash (Reload)
  - [ ] `SIGINT` (Signal 2) — Terminaldan uzish (`Ctrl + C`)
  - [ ] `SIGSTOP` (Signal 19) — Jarayonni vaqtincha to‘xtatib turish (`Ctrl + Z`)
  - [ ] `kill -15 PID` va `kill -9 PID`
  - [ ] `pkill process_name` va `killall process_name`
- [ ] Job Control (Terminalda vazifalarni boshqarish):
  - [ ] `&` belgisi orqali buyruqni orqa fonda (background) yurgizish
  - [ ] `jobs` — Fondagi vazifalar ro‘yxatini ko‘rish
  - [ ] `fg %1` — Vazifani old fonga (foreground) qaytarish
  - [ ] `bg %1` — To‘xtab turgan vazifani fonda davom ettirish
  - [ ] `nohup command &` — Terminal yopilsa ham jarayon o‘lmasligini ta'minlash
  - [ ] `disown` — Jarayonni terminal nazoratidan chiqarish
- [ ] Tizim resurslari va yuki (Load Average):
  - [ ] `uptime` — Tizim qancha vaqtdan beri ishlayotganini ko‘rish
  - [ ] Load Average nima (1 daqiqa, 5 daqiqa, 15 daqiqalik o‘rtacha yuk)
  - [ ] CPU Core soni va Load Average nisbati (tizim tiqilinchini aniqlash)
  - [ ] `free -m` va `free -h` — Operativ xotira (RAM) va Swap holati
  - [ ] Swap xotira nima va OOM Killer (Out Of Memory Killer) qanday ishlaydi
  - [ ] `dmesg -T | grep -i oom` — OOM Killer xatolarini logdan topish
  - [ ] `vmstat 1 5` — Virtual xotira va CPU statistikasini soniyama-soniya ko‘rish
  - [ ] `iostat -xz 1` — Disk I/O tezligi va tiqilinchini tekshirish

---

## 6-BOSQICH: Disk, Fayl Tizimi va Saqlash (Storage & Filesystems)
- [ ] Blokli qurilmalar (Block Devices):
  - [ ] `/dev/sdX` (SATA/SCSI disklari) va `/dev/nvmeXnY` (NVMe disklari) nomlanishi
  - [ ] MBR (Master Boot Record) va GPT (GUID Partition Table) farqlari
  - [ ] `lsblk` — Blokli qurilmalar daraxtini ko‘rish
  - [ ] `fdisk -l` — Disk bo‘limlari (partitions) ro‘yxatini ko‘rish
  - [ ] `blkid` — Disk bo‘limlarining UUID (Unique ID) raqamlarini ko‘rish
- [ ] Fayl tizimlari (Filesystems):
  - [ ] Fayl tizimi nima (ext4, xfs, btrfs, zfs)
  - [ ] `mkfs.ext4 /dev/sdb1` — Bo‘limni formatlash
  - [ ] Inode nima (fayl nomi, ruxsati, hajmi va ma'lumot bloklariga ko‘rsatkich)
  - [ ] Diskda joy bo‘la turib, nima sababdan fayl yaratib bo‘lmasligi (`df -i` inode tugashi)
- [ ] Diskdan foydalanishni tahlil qilish:
  - [ ] `df -h` — Disk bo‘limlarining bandligini odam tushunadigan formatda ko‘rish
  - [ ] `df -i` — Inode'lar bandligini tekshirish
  - [ ] `du -sh folder/` — Papkaning umumiy diskdagi hajmini hisoblash
  - [ ] `du -ah --max-depth=1 /var | sort -hr | head -n 10` — Diskni to‘ldirgan eng katta 10 ta papkani topish
  - [ ] `ncdu` — Diskni vizual tozalash vositasi
- [ ] Montirovka qilish (Mounting):
  - [ ] `mount /dev/sdb1 /mnt` — Diskni katalogga ulash
  - [ ] `umount /mnt` — Diskni uzish
  - [ ] `lsof +D /mnt` yoki `fuser -m /mnt` — "Target is busy" xatosida diskni qaysi jarayon ushlab turganini topish
  - [ ] `/etc/fstab` fayli strukturasi (6 ta maydon: Device, Mountpoint, Type, Options, Dump, Pass)
  - [ ] Diskni UUID orqali `/etc/fstab` ga avtomat ulanadigan qilib kiritish
  - [ ] `mount -a` — `/etc/fstab` ni xatosiz qayta tekshirib ulash
- [ ] Bog‘lamalar (Links):
  - [ ] Hard Link (Qattiq bog‘lama) nima: bitta inodega bir nechta ism berish (`ln file link`)
  - [ ] Soft/Symbolic Link (Simvolik bog‘lama / Shortcut) nima (`ln -s /path/to/target linkname`)
  - [ ] Hard link va Soft link farqlari (turli disklarda ishlashi, original o‘chganda nima bo‘lishi)
  - [ ] "Broken symlink" (singan simvolik havola) nima va uni qanday aniqlash

---

## 7-BOSQICH: Paketlar Boshqaruvi va Arxivlash
- [ ] Linux Paket Menejerlari:
  - [ ] Debian/Ubuntu oilasi: `apt`, `dpkg`
  - [ ] RHEL/CentOS/Fedora oilasi: `dnf`, `yum`, `rpm`
  - [ ] Arch Linux oilasi: `pacman`
  - [ ] Paket keshini yangilash (`apt update` vs `apt upgrade`)
  - [ ] Paketlarni o‘rnatish, o‘chirish va tozalash (`apt install`, `apt remove`, `apt purge`, `apt autoremove`)
  - [ ] Repozitoriylar nima va ular qayerda saqlanadi (`/etc/apt/sources.list`, `/etc/apt/sources.list.d/`)
- [ ] Arxivlash va Siqish (Archiving & Compression):
  - [ ] Arxivlash (`tar`) va Siqish (`gzip`, `bzip2`, `xz`) o‘rtasidagi farq
  - [ ] `tar -cvf archive.tar folder/` — Arxiv yaratish (Create, Verbose, File)
  - [ ] `tar -xvf archive.tar` — Arxivni ochish (Extract)
  - [ ] `tar -czvf archive.tar.gz folder/` — Gzip bilan siqilgan arxiv yaratish
  - [ ] `tar -xzvf archive.tar.gz` — Gzip arxivini ochish
  - [ ] `tar -tf archive.tar` — Arxivni ochmasdan ichidagi fayllarni ko‘rish
  - [ ] `gzip file` va `gunzip file.gz`
  - [ ] `zip -r archive.zip folder/` va `unzip archive.zip`

---

## 8-BOSQICH: Systemd, Xizmatlar (Daemons) va Init
- [ ] Init tizimlari evolyutsiyasi: SysVinit ➔ Upstart ➔ Systemd.
- [ ] Systemd nima va nega u PID 1 sifatida ishlaydi.
- [ ] Systemd Unit turlari: `.service`, `.socket`, `.target`, `.timer`, `.mount`.
- [ ] Systemd Target tushunchasi (Runlevels o‘rniga): `multi-user.target`, `graphical.target`, `rescue.target`.
- [ ] `systemctl` boshqaruv buyruqlari:
  - [ ] `systemctl start service_name` — Ishga tushirish
  - [ ] `systemctl stop service_name` — To‘xtatish
  - [ ] `systemctl restart service_name` — Qayta ishga tushirish
  - [ ] `systemctl reload service_name` — Konfiguratsiyani uzilishsiz yangilash
  - [ ] `systemctl status service_name` — Holatini ko‘rish
  - [ ] `systemctl enable service_name` — Server yonganda avtomat ishga tushadigan qilish
  - [ ] `systemctl disable service_name` — Avtomat ishga tushishni o‘chirish
  - [ ] `systemctl is-active service_name` va `systemctl is-enabled service_name`
  - [ ] `systemctl daemon-reload` — Yangi yoki o‘zgargan unit fayllarni tizimga tanitish
  - [ ] `systemctl mask service_name` — Xizmatni hech kim va hech qachon yoqa olmasligi uchun qulflash
- [ ] Unit Fayl Strukturasi (`.service`):
  - [ ] `[Unit]` bo‘limi:
    - [ ] `Description=` — Inson tushunadigan izoh
    - [ ] `After=` va `Before=` — Qaysi xizmatlardan oldin/keyin yoqilishi
    - [ ] `Wants=` (tavsiya) va `Requires=` (qat'iy bog‘liqlik) farqi
  - [ ] `[Service]` bo‘limi:
    - [ ] `ExecStart=` — Ishga tushirish buyrug‘i (DOIM to‘liq yo‘l bilan)
    - [ ] `ExecStop=` va `ExecReload=`
    - [ ] `WorkingDirectory=` — Dastur qaysi papka ichida turib ishlashi
    - [ ] `User=` va `Group=` — Xavfsizlik uchun xizmatni cheklangan user nomidan yurgizish
    - [ ] `Restart=` parametrlari (`always`, `on-failure`, `no`)
    - [ ] `RestartSec=` — Qayta tirilish orasidagi tanaffus (CrashLoop bo‘ronidan saqlash)
    - [ ] `Environment=` va `EnvironmentFile=` — Muhit o‘zgaruvchilarini yuklash
    - [ ] `Type=` turlari (`simple`, `exec`, `forking`, `oneshot`, `notify`)
  - [ ] `[Install]` bo‘limi:
    - [ ] `WantedBy=multi-user.target` — Qaysi targetga ulanishi
- [ ] Jurnallar va Loglar (`journalctl`):
  - [ ] `journalctl -u service_name` — Faqat ma'lum bir xizmat loglarini ko‘rish
  - [ ] `journalctl -u service_name -f` — Loglarni real vaqtda jonli kuzatish
  - [ ] `journalctl -u service_name -n 50` — Oxirgi 50 qatorni ko‘rish
  - [ ] `journalctl -b` — Faqat oxirgi kompyuter yoqilgandan keyingi loglarni ko‘rish
  - [ ] `journalctl -p err` — Faqat xatolik (Error/Critical) darajasidagi loglarni filtrlash
  - [ ] `journalctl --since "1 hour ago"` — Vaqt bo‘yicha qidirish
  - [ ] `journalctl --vacuum-size=500M` — Loglar hajmini tozalash va cheklash
- [ ] Systemd User Services:
  - [ ] `~/.config/systemd/user/` katalogi maqsadi (sudo'siz shaxsiy xizmatlar)
  - [ ] `systemctl --user` buyruqlari
  - [ ] `loginctl enable-linger username` (user tizimdan chiqib ketsa ham xizmat fon rejimida ishlashini ta'minlash)
- [ ] Rejali vazifalar (Cron vs Timers):
  - [ ] `cron` sintaksisi: `* * * * *` (Minut, Soat, Kun, Oy, Hafta kuni)
  - [ ] `crontab -e` (tahrirlash) va `crontab -l` (ko‘rish)
  - [ ] Systemd Timer (`.timer`) yaratish va afzalliklari

---

## 9-BOSQICH: Tarmoq Asoslari (Networking for DevOps)
- [ ] Tarmoq modellari:
  - [ ] OSI 7 qatlamli modeli (Physical, Data Link, Network, Transport, Session, Presentation, Application)
  - [ ] TCP/IP 4 qatlamli modeli (Link, Internet, Transport, Application)
  - [ ] Har bir qatlamda ma'lumot qanday enkapsulyatsiya bo‘lishi (Frame ➔ Packet ➔ Segment ➔ Data)
- [ ] IP Manzillash (IPv4):
  - [ ] IP manzil strukturasi (32 bit, 4 ta oktet)
  - [ ] Subnet Mask (Tarmoq niqobi) nima (`255.255.255.0`)
  - [ ] **CIDR (Classless Inter-Domain Routing) notatsiyasi:**
    - [ ] `/32` — Yagona 1 ta IP manzil
    - [ ] `/24` — 256 ta IP (254 ta foydalanish mumkin)
    - [ ] `/16` — 65 536 ta IP
    - [ ] Tarmoq manzili (Network ID) va Efir manzili (Broadcast IP) tushunchalari
  - [ ] Ommaviy (Public) va Maxfiy (Private) IP manzillar:
    - [ ] RFC 1918 standartidagi lokal tarmoq diapazonlari:
      - [ ] `10.0.0.0/8`
      - [ ] `172.16.0.0/12`
      - [ ] `192.168.0.0/16`
    - [ ] Loopback diapazoni: `127.0.0.0/8` (`127.0.0.1` localhost)
    - [ ] Nega `0.0.0.0` barcha interfeyslarni bildiradi (INADDR_ANY)
- [ ] Transport protokollari:
  - [ ] **TCP (Transmission Control Protocol):**
    - [ ] Kafolatlangan yetkazish, ulanishga asoslangan
    - [ ] TCP 3-Way Handshake (SYN ➔ SYN-ACK ➔ ACK)
    - [ ] Ulanishni yopish (FIN ➔ ACK)
    - [ ] Paketlar ketma-ketligi va yo‘qolgan paketlarni qayta so‘rash
  - [ ] **UDP (User Datagram Protocol):**
    - [ ] Ulanishsiz, kafolatsiz, lekin o‘ta tez (DNS, video oqimlar)
- [ ] Portlar tushunchasi:
  - [ ] Port nima (bitta IP ichida qaysi dasturga murojaat qilinayotganini belgilovchi raqam: 1–65535)
  - [ ] Mashhur standart portlar:
    - [ ] `22` — SSH
    - [ ] `53` — DNS
    - [ ] `80` — HTTP
    - [ ] `443` — HTTPS
    - [ ] `3306` — MySQL
    - [ ] `5432` — PostgreSQL
    - [ ] `6379` — Redis
    - [ ] `27017` — MongoDB
- [ ] Asosiy tarmoq xizmatlari:
  - [ ] **DNS (Domain Name System):**
    - [ ] Domenni IP ga aylantirish ierarxiyasi (Root serverlar ➔ TLD ➔ Authoritative DNS)
    - [ ] DNS Yozuv turlari: `A`, `AAAA`, `CNAME`, `MX`, `TXT`, `PTR`, `NS`, `SOA`
    - [ ] DNS TTL (Time To Live) va kesh tushunchasi
    - [ ] `/etc/hosts` fayli (lokal DNSOverride)
    - [ ] `/etc/resolv.conf` fayli (Nameserverlarni ko‘rsatish)
  - [ ] **NAT (Network Address Translation):**
    - [ ] SNAT (Source NAT) va DNAT (Destination NAT) / Port Forwarding
    - [ ] Qanday qilib butun ofis bitta Public IP orqali internetga chiqadi
  - [ ] **DHCP (Dynamic Host Configuration Protocol):**
    - [ ] DORA jarayoni (Discover, Offer, Request, Acknowledge)

---

## 10-BOSQICH: Tarmoq Diagnostikasi va Xavfsizlik Devorlari (Firewalls)
- [ ] Tarmoq interfeyslari va marshrutlash (Routing):
  - [ ] `ip addr` yoki `ip a` — Barcha tarmoq kartalari va ularning IP manzillarini ko‘rish
  - [ ] `ip link set eth0 up/down` — Tarmoq kartasini yoqish/o‘chirish
  - [ ] `ip route` — Standart shlyuz (Default Gateway) va marshrutlar jadvalini ko‘rish
- [ ] Tarmoq tekshirish va nosozliklarni qidirish (Troubleshooting):
  - [ ] `ping host` — ICMP orqali server bilan aloqani va paket yo‘qolishini (packet loss) tekshirish
  - [ ] `ping -c 4 host` — Aniq 4 ta paket yuborish
  - [ ] `traceroute host` yoki `mtr host` — Paket internet bo‘ylab qaysi marshrutizatorlar (hop) orqali o‘tayotganini va qayerda tiqilayotganini aniqlash
  - [ ] `dig domain.com` — DNS serverdan to‘liq yozuvlarni so‘rash
  - [ ] `dig domain.com +short` — Faqat IP natijani olish
  - [ ] `dig @8.8.8.8 domain.com` — Aniq DNS serverga murojaat qilish
  - [ ] `nslookup domain.com` va `host domain.com`
- [ ] Ochiq portlar va ulanishlarni tekshirish:
  - [ ] `ss -tulpn` — Serverda qaysi portlar qaysi dasturlar tomonidan eshitilayotganini (`LISTEN`) ko‘rish:
    - [ ] `-t` (TCP), `-u` (UDP), `-l` (Listening), `-p` (Process/PID), `-n` (Numeric portlar)
  - [ ] `netstat -tulpn` (eski muqobili)
  - [ ] `nc -zv host port` (Netcat) — Tashqi serverdagi port ochiq yoki yopiqligini 1 soniyada tekshirish
  - [ ] `nmap -p 80,443,22 host` — Server portlarini skanerlash
- [ ] HTTP so‘rovlari vositasi (`curl`):
  - [ ] `curl http://example.com` — HTML/JSON javobni olish
  - [ ] `curl -I http://example.com` — Faqat HTTP Header'larni ko‘rish (Status code: 200, 301, 404, 502)
  - [ ] `curl -v http://example.com` — To‘liq batafsil ulanish jarayonini (Handshake, SSL, Headers) ko‘rish
  - [ ] `curl -X POST -H "Content-Type: application/json" -d '{"key":"value"}' URL` — REST API ga POST so‘rov yuborish
  - [ ] `curl -k` yoki `--insecure` — Noto‘g‘ri/o‘zi imzolagan SSL sertifikatlarni chetlab o‘tish
  - [ ] `curl -L` — Redirect'lar (301/302) orqasidan ergashish
  - [ ] `curl -s` (Silent mode) skriptlar uchun
  - [ ] `wget URL` — Fayllarni internetdan to‘g‘ridan-to‘g‘ri yuklab olish
- [ ] Paketlarni ushlash va tahlil qilish:
  - [ ] `tcpdump -i any port 80 -nn -X` — Tarmoqdan o‘tayotgan tirik xom paketlarni tahlil qilish
- [ ] Linux Xavfsizlik Devorlari (Firewalls):
  - [ ] `iptables` asosiy tushunchalari: Tables (Filter, Nat) va Chains (INPUT, OUTPUT, FORWARD)
  - [ ] Qoidalar: `ACCEPT`, `DROP`, `REJECT`
  - [ ] `iptables -L -v -n` — Faol qoidalarni ko‘rish
  - [ ] `ufw` (Uncomplicated Firewall — Ubuntu):
    - [ ] `ufw status`
    - [ ] `ufw allow 22/tcp`
    - [ ] `ufw allow from 192.168.1.50 to any port 3306`
    - [ ] `ufw enable` va `ufw disable`
  - [ ] `firewalld` (RHEL/CentOS): zonalarga asoslangan boshqaruv (`firewall-cmd`)

---

## 11-BOSQICH: SSH va Masofaviy Boshqaruv
- [ ] SSH (Secure Shell) protokoli nima (22-port, shifrlangan kanal).
- [ ] Parolli autentifikatsiya nega xavfli (Brute-force hujumlari).
- [ ] Asimmetrik kriptografiya (Public va Private Key juftligi) qanday ishlaydi:
  - [ ] Private Key — faqat sizning kompyuteringizda saqlanadi (hech kimga berilmaydi!)
  - [ ] Public Key — serverga joylanadi
- [ ] SSH kalitlarini yaratish:
  - [ ] `ssh-keygen -t ed25519 -C "email@example.com"` (Zamonaviy, xavfsiz va tez)
  - [ ] `ssh-keygen -t rsa -b 4096` (Eski RSA standarti)
  - [ ] Kalitga pass-phrase (parol) qo‘yish va `ssh-agent` orqali uni keshda saqlash
- [ ] Serverga kalitni o‘rnatish:
  - [ ] `ssh-copy-id -i ~/.ssh/id_ed25519.pub user@server_ip`
  - [ ] Qo‘lda o‘rnatish: `~/.ssh/authorized_keys` fayliga public keyni qo‘shish
  - [ ] **Kritik ruxsatlar qoidasi (aks holda SSH kiritmaydi):**
    - [ ] `chmod 700 ~/.ssh`
    - [ ] `chmod 600 ~/.ssh/authorized_keys`
    - [ ] `chmod 600 ~/.ssh/id_ed25519`
- [ ] Server xavfsizligini ta'minlash (`/etc/ssh/sshd_config`):
  - [ ] `PasswordAuthentication no` — Parol bilan kirishni butunlay taqiqlash
  - [ ] `PermitRootLogin no` — To‘g‘ridan-to‘g‘ri root bo‘lib kirishni taqiqlash
  - [ ] `Port 2222` — Standart portni o‘zgartirish
  - [ ] `sudo systemctl restart sshd`
- [ ] SSH mijoz konfiguratsiyasi (`~/.ssh/config`):
  - [ ] Har safar uzun IP va kalit yo‘lini yozmaslik uchun aliaslar yaratish:
    ```ini
    Host myserver
        HostName 198.51.100.5
        User ubuntu
        Port 22
        IdentityFile ~/.ssh/my_key
    ```
  - [ ] `ssh myserver` orqali 1 soniyada ulanish
  - [ ] SSH Multiplexing (`ControlMaster`, `ControlPath`, `ControlPersist`) ulanishni 0.1s ga tezlashtirish
- [ ] SSH orqali portlarni yo‘naltirish (SSH Tunneling):
  - [ ] **Local Port Forwarding (`ssh -L 8080:localhost:5432 user@server`):** Serverdagi yopiq bazani lokal kompyuterda ochish
  - [ ] **Remote Port Forwarding (`ssh -R`):** Lokal dasturni tashqi serverga ko‘rsatish
- [ ] Fayllarni xavfsiz ko‘chirish:
  - [ ] `scp file user@server:/remote/dir/`
  - [ ] `scp -r folder/ user@server:/remote/dir/`
  - [ ] `rsync -avz --progress local/ user@server:/remote/` — Faqat o‘zgargan fayllarni siqib, delta orqali nusxalash
  - [ ] `rsync --delete` — Manbada o‘chirilgan fayllarni serverda ham o‘chirib to‘liq sinxronlash

---

## 12-BOSQICH: Git va Versiyalarni Boshqarish (VCS)
- [ ] Git Mental Modeli:
  - [ ] Uchta hudud: Working Directory ➔ Staging Area (Index) ➔ Git Repository (Commits)
  - [ ] Fayl holatlari: Untracked ➔ Modified ➔ Staged ➔ Committed
- [ ] Boshlang‘ich sozlamalar:
  - [ ] `git config --global user.name "Ismingiz"`
  - [ ] `git config --global user.email "emailingiz"`
  - [ ] `git config --global init.defaultBranch main`
  - [ ] GitHub bilan SSH orqali bog‘lanish
- [ ] Asosiy buyruqlar:
  - [ ] `git init` — Yangi repozitoriy ochish
  - [ ] `git clone <url>` — Mavjud repozitoriyni yuklab olish
  - [ ] `git status` — Hozirgi holatni ko‘rish
  - [ ] `git add file` va `git add .` — Staging areaga o‘tkazish
  - [ ] `git diff` — Working directorydagi o‘zgarishlarni ko‘rish
  - [ ] `git diff --staged` — Staging areadagi o‘zgarishlarni ko‘rish
  - [ ] `git commit -m "commit xabari"` — O‘zgarishlarni qayd etish
  - [ ] `git log --oneline --graph --decorate` — Tarixni chiroyli daraxt shaklida ko‘rish
  - [ ] `git show <commit_hash>` — Aniq bitta commitda nima o‘zgarganini ko‘rish
- [ ] Tarmoqlar (Branches):
  - [ ] Branch nima (commits zanjiriga ko‘rsatuvchi yengil marker)
  - [ ] `git branch` — Tarmoqlar ro‘yxati
  - [ ] `git branch feature-name` — Yangi tarmoq ochish
  - [ ] `git checkout feature-name` yoki `git switch feature-name` — Tarmoqqa o‘tish
  - [ ] `git checkout -b feature-name` — Ochish va birdaniga o‘tish
  - [ ] `git merge feature-name` — Tarmoqni asosiy tarmoqqa birlashtirish
  - [ ] Merge Conflict (Ziddiyat) nima va uni qanday hal qilish (`<<<<<<< HEAD`, `=======`, `>>>>>>>`)
  - [ ] `git rebase main` — Tarixni chiziqli (toza) saqlash usuli
  - [ ] Fast-forward merge va 3-way merge farqi
- [ ] Masofaviy repozitoriy (Remote):
  - [ ] `git remote -v` — Masofaviy manzillarni ko‘rish
  - [ ] `git fetch` — Serverdagi yangiliklarni yuklab olish (lekin merge qilmaslik)
  - [ ] `git pull` — `fetch` + `merge`ni birdaniga bajarish
  - [ ] `git push origin branch-name` — O‘zgarishlarni serverga yuklash
- [ ] Xatolarni bekor qilish (Undoing changes):
  - [ ] `git restore file` — O‘zgartirilgan faylni oxirgi commit holatiga qaytarish
  - [ ] `git restore --staged file` — Faylni staging areadan chiqarish
  - [ ] `git commit --amend` — Oxirgi commit xabarini yoki tarkibini to‘g‘rilash
  - [ ] `git stash` — Tugallanmagan ishlarni vaqtincha cho‘ntakka olib turish
  - [ ] `git stash pop` — Saqlangan ishlarni qaytarib olish
  - [ ] `git reset --soft HEAD~1` — Oxirgi commitni bekor qilish, lekin kodni saqlab qolish
  - [ ] `git reset --hard HEAD~1` — Oxirgi commitni kodi bilan birga butunlay yo‘q qilish (xavfli!)
  - [ ] `git revert <commit_hash>` — Xatolik kiritgan commitni bekor qiluvchi yangi xavfsiz commit yaratish
- [ ] Tozalik:
  - [ ] `.gitignore` fayli sintaksisi (`*.log`, `node_modules/`, `.env`)
  - [ ] Maxfiy kalitlar va parollarni hech qachon gitga qo‘shmaslik qoidasi

---

## 13-BOSQICH: Bash Scripting va Avtomatlashtirish
- [ ] Skript anatomiyasi:
  - [ ] Shebang: `#!/usr/bin/env bash` (nega aynan shu uslub to‘g‘ri ekanligi)
  - [ ] Skriptga ijro ruxsatini berish: `chmod +x script.sh`
  - [ ] Skriptni yurgizish: `./script.sh` yoki `bash script.sh`
- [ ] **Xavfsiz Skripting Qoidasi (Unofficial Strict Mode):**
  - [ ] `set -e` — Biror buyruq xato bilan tugasa, darhol to‘xtash
  - [ ] `set -u` — E'lon qilinmagan o‘zgaruvchi ishlatilsa, xato berish
  - [ ] `set -o pipefail` — Quvur ichidagi bitta buyruq yiqilsa ham xato deb hisoblash
  - [ ] `set -euo pipefail` — Har bir professional skriptning birinchi qatori
- [ ] O‘zgaruvchilar va Ma'lumot turlari:
  - [ ] O‘zgaruvchi e'lon qilish: `NAME="Sanjar"` (bo‘sh joy qoldirish qat'iyan man etiladi)
  - [ ] Qo‘shtirnoqlar farqi:
    - [ ] Qattiq qo‘shtirnoq (`'...'`) — o‘zgaruvchini kengaytirmaydi (literal)
    - [ ] Yumshoq qo‘shtirnoq (`"..."`) — o‘zgaruvchilarni qiymatiga almashtiradi (`$NAME`)
  - [ ] Maxsus o‘zgaruvchilar:
    - [ ] `$?` — Oxirgi bajarilgan buyruqning chiqish kodi (Exit Code: 0 = muvaffaqiyat, 0 dan farqli = xato)
    - [ ] `$#` — Skriptga berilgan argumentlar soni
    - [ ] `$0` — Skriptning o‘zining nomi
    - [ ] `$1, $2, $3` — 1-chi, 2-chi, 3-chi argumentlar
    - [ ] `$@` va `$*` — Barcha argumentlar ro‘yxati
    - [ ] `$$` — Skriptning o‘zining PID raqami
- [ ] Shart operatorlari (Conditionals):
  - [ ] `if [ condition ]; then ... fi` va zamonaviy `if [[ condition ]]; then ... fi`
  - [ ] Sonlarni solishtirish: `-eq`, `-ne`, `-lt`, `-le`, `-gt`, `-ge`
  - [ ] Satrlarni solishtirish: `==`, `!=`, `-z` (satr bo‘shligini tekshirish), `-n` (satr to‘laligini tekshirish)
  - [ ] Fayl va papkalarni tekshirish:
    - [ ] `-f /path/to/file` — Fayl mavjudmi?
    - [ ] `-d /path/to/dir` — Papka mavjudmi?
    - [ ] `-s /path/to/file` — Fayl bo‘sh emasmi?
    - [ ] `-x /path/to/file` — Fayl ijro etiluvchimi?
  - [ ] Mantiqiy bog‘lovchilar: `&&` (AND), `||` (OR), `!` (NOT)
  - [ ] `command1 && command2` (1-chi muvaffaqiyatli bo‘lsa, 2-chini bajar)
  - [ ] `command1 || command2` (1-chi xato bo‘lsa, 2-chini bajar)
- [ ] Sikllar (Loops):
  - [ ] `for item in apple banana orange; do ... done`
  - [ ] `for file in /var/log/*.log; do ... done`
  - [ ] `for ((i=1; i<=10; i++)); do ... done`
  - [ ] `while [ condition ]; do ... done`
  - [ ] Faylni qatorma-qator to‘g‘ri o‘qish:
    ```bash
    while IFS= read -r line; do
        echo "Qator: $line"
    done < file.txt
    ```
- [ ] Funksiyalar (Functions):
  - [ ] Funksiya e'lon qilish: `log_message() { local msg="$1"; ... }`
  - [ ] `local` kalit so‘zi bilan o‘zgaruvchilar doirasini cheklash
  - [ ] Funksiyadan qiymat qaytarish (`return 0` yoki `echo "natija"`)
- [ ] Trap va xatolarni ushlash:
  - [ ] `trap 'rm -f /tmp/tempfile; echo "Tozalandi"' EXIT` — Skript qanday to‘xtashidan qat'i nazar vaqtinchalik fayllarni o‘chirish
- [ ] Real DevOps amaliy vazifasi:
  - [ ] Server monitoring skripti: Disk > 85% yoki RAM > 90% bo‘lsa, log yozadigan va Telegramga xabar yuboradigan skript yozish

---

## 14-BOSQICH: Python (DevOps uchun Amaliyot)
- [ ] Nega DevOps'ga Python kerak (Bash yetmay qolgan joyda murakkab JSON, API va avtomatlashtirish uchun).
- [ ] Python asoslari:
  - [ ] O‘zgaruvchilar, List, Dictionary, Tuples
  - [ ] Shartlar va Sikllar (`if`, `for`, `while`)
  - [ ] Funksiyalar va Xatolarni ushlash (`try ... except ... finally`)
- [ ] DevOps uchun muhim kutubxonalar:
  - [ ] `sys` va `sys.argv`, `sys.exit(1)`
  - [ ] `os` va `os.environ.get("PORT", 8080)`, `os.path`
  - [ ] `pathlib` — Zamonaviy fayllar bilan ishlash
  - [ ] `json` — JSON fayllarni o‘qish va yozish (`json.loads`, `json.dumps`)
  - [ ] `subprocess` moduli: Linux buyruqlarini Python ichidan yurgizish (`subprocess.run(["docker", "ps"], capture_output=True, text=True)`)
- [ ] Tarmoq va API so‘rovlari (`requests` yoki `urllib`):
  - [ ] Tashqi API lardan ma'lumot olish (GET)
  - [ ] Alert yuborish (Telegram botga xabar yuborish skripti)
- [ ] Virtual muhit (Virtualenv):
  - [ ] `python -m venv .venv`
  - [ ] `source .venv/bin/activate`
  - [ ] `pip install -r requirements.txt` va `pip freeze > requirements.txt`

---

## 15-BOSQICH: Docker va Konteynerizatsiya
- [ ] Konteyner Mental Modeli:
  - [ ] Virtual Mashina (VM) va Konteyner farqlari (Hypervisor vs OS-level virtualization)
  - [ ] Linux Yadro mexanizmlari:
    - [ ] **Namespaces (Izolyatsiya):** PID (jarayonlar), NET (tarmoq), MNT (fayl tizimi), IPC, UTS, USER
    - [ ] **Control Groups (Cgroups):** Resurslarni cheklash (CPU, RAM, Disk I/O limitlari)
    - [ ] **UnionFS / Overlay2:** Qatlamli (Layered) fayl tizimi
- [ ] Docker Arxitekturasi:
  - [ ] Docker Client (CLI) ➔ Docker Daemon (`dockerd`) ➔ `containerd` ➔ `runc`
  - [ ] Docker Image (Rasm/Qolip) va Docker Container (Tirik nusxa) farqi
- [ ] Konteynerlar bilan ishlash buyruqlari:
  - [ ] `docker run -d --name mynginx -p 8080:80 nginx:alpine` buyrug‘ining har bir parametrini tushunish
  - [ ] `docker ps` — Faqat ishlab turganlarni ko‘rish
  - [ ] `docker ps -a` — Barcha (to‘xtagan) konteynerlarni ko‘rish
  - [ ] `docker stop <id>` va `docker start <id>`
  - [ ] `docker restart <id>`
  - [ ] `docker rm <id>` va `docker rm -f <id>`
  - [ ] `docker logs <id>` (`-f`, `--tail 100`)
  - [ ] `docker exec -it <id> sh` yoki `bash` — Ishlab turgan konteyner ichiga kirish
  - [ ] `docker inspect <id>` — Konteynerning to‘liq JSON konfiguratsiyasini ko‘rish
  - [ ] `docker stats` — Konteynerlarning CPU va RAM sarfini jonli ko‘rish
- [ ] Docker Imijlari (Images):
  - [ ] `docker images` — Mavjud imijlar ro‘yxati
  - [ ] `docker pull <image>` va `docker push <image>`
  - [ ] `docker rmi <image_id>` — Imijni o‘chirish
  - [ ] `docker system prune -a --volumes` — Barcha keraksiz konteyner, tarmoq va imijlarni tozalash
- [ ] `Dockerfile` yozish (Professional uslub):
  - [ ] `FROM` — Baza imij tanlash (Alpine, Debian-slim)
  - [ ] `WORKDIR` — Ishchi papkani belgilash
  - [ ] `COPY` va `ADD` farqi (nega doim `COPY` tanlanadi)
  - [ ] `RUN` — Imij yaratish vaqtida buyruq bajarish
  - [ ] **Kesh qatlamlari (Layer Caching) siri:** `requirements.txt` yoki `package.json`ni koddan oldin nusxalash nega build vaqtini 10 barobar tejaydi
  - [ ] `CMD` va `ENTRYPOINT` farqi (Exec form `["executable", "param"]` vs Shell form)
  - [ ] `ENV` (konteyner ishlashida qoladi) va `ARG` (faqat build vaqtida kerak) farqi
  - [ ] `EXPOSE` — Hujjatlashtirish porti
  - [ ] `USER` — Xavfsizlik: Root emas, alohida `appuser` yaratib ishlatish
  - [ ] `HEALTHCHECK` — Konteyner sog‘lig‘ini tekshirish direktivasi
  - [ ] `.dockerignore` fayli (node_modules, .git, .env kabilarni kirmasligini ta'minlash)
  - [ ] **Multi-stage Build:**
    - [ ] Nega kerak (Builder bosqichida kutubxonalarni kompilyatsiya qilib, yakuniy imijga faqat binarni olish)
    - [ ] Imij hajmini 1 GB dan 30 MB ga tushirish
- [ ] Docker Tarmoqlari (Networking):
  - [ ] Tarmoq turlari:
    - [ ] `bridge` — Standart izolyatsiyalangan tarmoq
    - [ ] `host` — Host mashina tarmog‘idan to‘g‘ridan-to‘g‘ri foydalanish
    - [ ] `none` — Tarmoqni butunlay uzish
    - [ ] `overlay` — Bir nechta serverlararo tarmoq (Swarm/K8s)
  - [ ] `docker network create my-net`
  - [ ] Maxsus yaratilgan bridge tarmoqda **Docker Embedded DNS** ishlashi (konteynerlar IP emas, o‘z nomi orqali bog‘lanishi)
  - [ ] Port Mapping: `-p 8088:80` (HostPort:ContainerPort)
  - [ ] Nega ilova konteyner ichida `127.0.0.1` emas, `0.0.0.0` da tinglashi shartligi
- [ ] Docker Ma'lumotlarni Saqlash (Storage):
  - [ ] Konteynerning o‘chuvchan (ephemeral) tabiati
  - [ ] **Bind Mounts (`-v ./data:/app/data`):** Host papkasini to‘g‘ridan-to‘g‘ri ulash (dasturlash uchun qulay, ruxsatlar bilan bog‘liq nozikliklar)
  - [ ] **Named Volumes (`-v db_data:/var/lib/postgresql/data`):** Docker tomonidan boshqariladigan xavfsiz va tezkor joy (Production standarti)
  - [ ] `docker volume ls` va `docker volume inspect`
- [ ] Docker Compose:
  - [ ] Docker Compose nima uchun kerak (ko‘p konteynerli ilovalarni bitta faylda boshqarish)
  - [ ] `docker-compose.yml` strukturasi (`services`, `networks`, `volumes`)
  - [ ] Bog‘liqliklar: `depends_on`
  - [ ] `docker compose up -d` — Fon rejimida yoqish
  - [ ] `docker compose down` — To‘xtatish va tarmoqlarni tozalash
  - [ ] `docker compose down -v` — Volume'lari bilan birga o‘chirish
  - [ ] `docker compose ps` va `docker compose logs -f`
  - [ ] `docker compose up -d --build` — Kod o‘zgarganda qayta yig‘ib yoqish
  - [ ] Real loyiha: Nginx + Python API + PostgreSQL bazasini compose orqali bir tarmoqda bog‘lash

---

## 16-BOSQICH: Veb-Serverlar va Reverse Proxy (Nginx & Caddy)
- [ ] Veb-server va Reverse Proxy mental modeli:
  - [ ] Forward Proxy va Reverse Proxy farqlari
  - [ ] Nega dasturchining serverini (Node.js/Python) to‘g‘ridan-to‘g‘ri internetga ochish xavfli ekanligi
  - [ ] Reverse Proxy vazifalari: SSL Termination, Load Balancing, Caching, Static files, Rate limiting
- [ ] Nginx Konfiguratsiyasi:
  - [ ] Asosiy arxitektura: Master process va Worker processes
  - [ ] Fayllar joylashuvi: `/etc/nginx/nginx.conf`, `/etc/nginx/conf.d/` yoki `sites-available/` / `sites-enabled/`
  - [ ] `server` va `location` bloklari
  - [ ] `listen 80;` va `server_name example.com;`
  - [ ] Statik fayllarni tarqatish: `root /var/www/html;` va `index index.html;`
  - [ ] Reverse Proxy sozlash: `proxy_pass http://127.0.0.1:3000;`
  - [ ] Muhim proxy headerlar:
    - [ ] `proxy_set_header Host $host;`
    - [ ] `proxy_set_header X-Real-IP $remote_addr;`
    - [ ] `proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;`
    - [ ] `proxy_set_header X-Forwarded-Proto $scheme;`
  - [ ] `nginx -t` — Konfiguratsiya sintaksisini tekshirish
  - [ ] `systemctl reload nginx` — Uzilishsiz yangilash
  - [ ] Xatoliklarni o‘rganish: 502 Bad Gateway, 504 Gateway Timeout, 403 Forbidden sabablari
- [ ] SSL/TLS va HTTPS:
  - [ ] Shifrlash qanday ishlaydi (HTTPS, TLS sertifikatlar)
  - [ ] Certificate Authority (CA) va Let's Encrypt
  - [ ] `certbot` yordamida Nginx uchun bepul SSL o‘rnatish va avtomatik yangilanishini (`cron/timer`) sozlash
- [ ] Caddy Server:
  - [ ] Caddy afzalliklari (avtomatik HTTPS, sodda `Caddyfile`)
  - [ ] Docker ichida Caddy bilan ishlash

---

## 17-BOSQICH: CI/CD Pipeline (GitHub Actions)
- [ ] CI/CD Mental Modeli:
  - [ ] **CI (Continuous Integration):** Kodni muntazam integratsiya qilish, avtomatik testlash va tekshirish (Linting, Unit tests, Security scan)
  - [ ] **CD (Continuous Delivery):** Har qanday vaqtda bitta tugma bilan productionga chiqarishga tayyor holatda turish
  - [ ] **CD (Continuous Deployment):** Barcha testlardan o‘tgan kodning serverga hech qanday qo‘l aralashuvisiz avtomatik deploy bo‘lishi
- [ ] GitHub Actions Arxitekturasi:
  - [ ] Konfiguratsiya fayllari manzili: `.github/workflows/*.yml`
  - [ ] **Workflow:** Bitta umumiy avtomatlashtirish jarayoni
  - [ ] **Triggers (`on:`):**
    - [ ] `on: [push]`
    - [ ] `on: [pull_request]`
    - [ ] Aniq branchlar bo‘yicha: `branches: [main]`
    - [ ] `workflow_dispatch` (qo‘lda ishga tushirish tugmasi)
    - [ ] `schedule` (cron jadvali)
  - [ ] **Jobs:** Parallel yoki ketma-ket ishlaydigan vazifalar bloki (`runs-on: ubuntu-latest`)
  - [ ] **Steps:** Job ichidagi qadamma-qadam amallar
  - [ ] **Actions (`uses:`):** Jamiyat tomonidan yozilgan tayyor modullar (`actions/checkout@v4`, `actions/setup-python@v5`)
  - [ ] **Run (`run:`):** Terminalda oddiy bash buyruqlarini bajarish
- [ ] Xavfsizlik va Maxfiy Ma'lumotlar (Secrets):
  - [ ] Nega API kalitlar va parollar gitga yozilmaydi
  - [ ] GitHub Repository Secrets (`Settings ➔ Secrets and variables ➔ Actions`)
  - [ ] Ularni pipeline ichida ishlatish: `${{ secrets.SSH_PRIVATE_KEY }}`, `${{ secrets.DOCKER_PASSWORD }}`
- [ ] Kesh va Artefaktlar:
  - [ ] `actions/cache` — Bog‘liqliklarni (`npm install`, `pip install`) keshlab, pipeline tezligini oshirish
  - [ ] `actions/upload-artifact` va `download-artifact`
- [ ] Haqiqiy End-to-End DevOps Pipeline yaratish:
  - [ ] 1-qadam: Kodni gitdan yuklab olish (`checkout`)
  - [ ] 2-qadam: Testlarni yurgizish (agar test yiqilsa, pipeline to‘xtaydi)
  - [ ] 3-qadam: Docker imijni build qilish
  - [ ] 4-qadam: Imijni DockerHub yoki AWS ECR ga push qilish
  - [ ] 5-qadam: SSH orqali AWS EC2 serverga ulanib, yangi konteynerni ishga tushirish (Deploy)

---

## 18-BOSQICH: Cloud Infratuzilma (AWS)
- [ ] Bulutli hisoblash (Cloud Computing) asoslari:
  - [ ] IaaS (Infratuzilma — EC2), PaaS (Platforma — RDS), SaaS (Dasturiy ta'minot)
  - [ ] Shared Responsibility Model (AWS nimaga javobgar, siz nimaga javobgarsiz)
  - [ ] Global Infratuzilma: Regions (Mintaqalar) va Availability Zones (AZs) arxitekturasi
- [ ] **IAM (Identity and Access Management) — Barcha xavfsizlik negizi:**
  - [ ] Root User (faqat hisob ochish va to‘lovlar uchun, doimiy ishlatish qat'iyan man etiladi)
  - [ ] MFA (Multi-Factor Authentication) yoqish
  - [ ] IAM Users va IAM Groups
  - [ ] **Least Privilege prinsipi:** Faqat ish uchun zarur bo‘lgan minimal ruxsatlarni berish
  - [ ] IAM Policies (JSON strukturasi: `Effect: Allow/Deny`, `Action`, `Resource`)
  - [ ] **IAM Roles:** Foydalanuvchiga emas, AWS xizmatlariga (masalan, EC2 serverga) beriladigan vaqtinchalik xavfsiz ruxsatnoma
- [ ] **VPC (Virtual Private Cloud) — Shaxsiy izolyatsiyalangan tarmoq:**
  - [ ] Shaxsiy tarmoq yaratish (`CIDR` masalan `10.0.0.0/16`)
  - [ ] **Public Subnet:** Internetga to‘g‘ridan-to‘g‘ri chiqa oladigan zona (Veb-serverlar uchun)
  - [ ] **Private Subnet:** Tashqi internetdan butunlay yopiq zona (Ma'lumotlar bazasi uchun)
  - [ ] **Internet Gateway (IGW):** VPC'ni global internetga ulovchi eshik
  - [ ] **NAT Gateway:** Private subnetdagi serverlar internetga chiqishi mumkin, lekin internetdan ularga to‘g‘ridan-to‘g‘ri ulanib bo‘lmaydigan qilib sozlash
  - [ ] **Route Tables (Marshrutlar jadvali):** Subnetlar qaysi darvoza (IGW yoki NAT) orqali chiqishini belgilash
  - [ ] **Security Groups:** Server darajasidagi Stateful firewall (qaysi port va qaysi IP lardan kirish mumkinligini belgilash)
  - [ ] **Network ACLs (NACL):** Subnet darajasidagi Stateless firewall
- [ ] **EC2 (Elastic Compute Cloud) — Virtual Serverlar:**
  - [ ] Instansiya turlari: General Purpose (t3, t4g), Compute Optimized (c6), Memory Optimized (r6)
  - [ ] AMI (Amazon Machine Image): Ubuntu, Amazon Linux
  - [ ] SSH Key Pair yaratish va ulanish
  - [ ] **User Data:** Server birinchi yoqilganda avtomat bajariladigan bash skript (Docker, Nginx o‘rnatish)
  - [ ] Elastic IP (Doimiy statik ommaviy IP)
  - [ ] **EBS (Elastic Block Store):** EC2 serverning virtual qattiq diski (gp3, io2), snapshot (zaxira nusxa) olish
- [ ] **S3 (Simple Storage Service) — Obyektli xotira:**
  - [ ] Fayl tizimi emas, kalit-qiymat ko‘rinishidagi cheksiz sig‘imli xotira
  - [ ] Bucket va Objects tushunchasi
  - [ ] S3 Bucket ruxsatlari (Block Public Access, Bucket Policy)
  - [ ] Statik veb-saytlarni S3 da tekinga host qilish
  - [ ] Versiyalash (Versioning) va hayot sikli (Lifecycle rules — arxivga o‘tkazish)
- [ ] **ECR (Elastic Container Registry):**
  - [ ] Xususiy Docker imijlar omborini ochish
  - [ ] Docker login va imijlarni ECR ga push qilish
- [ ] **ECS (Elastic Container Service):**
  - [ ] Docker konteynerlarini klasterda boshqarish
  - [ ] Task Definition (Konteyner blueprint'i: RAM, CPU, Port, Image)
  - [ ] Service (Ilova nusxalarini doimiy ushlab turish)
  - [ ] **AWS Fargate:** Server boshqaruvisiz (Serverless) konteyner yurgizish
- [ ] **Load Balancing va DNS:**
  - [ ] **ALB (Application Load Balancer):** HTTP/HTTPS (7-qatlam) trafikni taqsimlash, Path-based routing
  - [ ] Target Groups va Health Checks
  - [ ] **Route 53:** Global DNS xizmati, domenlarni bog‘lash
- [ ] **Monitoring va Xarajat:**
  - [ ] CloudWatch Metrics (CPU, Disk, Network)
  - [ ] CloudWatch Alarms (Server qizib ketsa ogohlantirish)
  - [ ] CloudWatch Logs (Ilova loglarini jamlash)
  - [ ] AWS Budgets: 0$ dan oshib ketmasligi uchun ogohlantirish (Alert) qo‘yish

---

## 19-BOSQICH: Infratuzilma Kod Sifatida (Terraform - IaC)
- [ ] IaC (Infrastructure as Code) falsafasi:
  - [ ] Konsolda tugmalarni bosish nega professional emas (xatolar, takrorlab bo‘lmaslik)
  - [ ] Deklarativ (Declarative — "Menga nima kerakligini aytaman") va Imperativ (Imperative — "Qanday qilishni buyuraman") farqi
  - [ ] Infratuzilmani Gitda xuddi kod kabi versiyalash
- [ ] Terraform Asoslari va Sintaksisi (HCL — HashiCorp Configuration Language):
  - [ ] `providers` — Qaysi bulut bilan ishlash (`provider "aws" { region = "eu-north-1" }`)
  - [ ] `resources` — Yaratiladigan resurslar (`resource "aws_instance" "web" { ... }`)
  - [ ] `data` — Mavjud ma'lumotlarni o‘qib olish
  - [ ] `variables` — O‘zgaruvchilar (`variables.tf` va `terraform.tfvars`)
  - [ ] `outputs` — Natijalarni ekranga chiqarish (masalan, yaratilgan server IP manzili)
  - [ ] `locals` — Ichki hisoblangan o‘zgaruvchilar
- [ ] Asosiy ishchi sikl (Core Workflow):
  - [ ] `terraform init` — Provayder plaginlarini yuklab olish va muhitni tayyorlash
  - [ ] `terraform fmt` — Kodni chiroyli formatlash
  - [ ] `terraform validate` — Sintaksis xatolarini tekshirish
  - [ ] `terraform plan` — Nimalar yaratilishi, o‘zgarishi yoki o‘chirilishini oldindan ko‘rish
  - [ ] `terraform apply` — Infratuzilmani real bulutda yaratish
  - [ ] `terraform destroy` — Barcha yaratilgan resurslarni bitta buyruq bilan o‘chirish
- [ ] Holat fayli (Terraform State):
  - [ ] `terraform.tfstate` fayli nima va u real dunyo bilan kodni qanday bog‘laydi
  - [ ] Nega state faylni hech qachon gitga yuklash mumkin emas (maxfiy parollar bo‘ladi)
  - [ ] **Remote State (Masofaviy holat):** State faylni AWS S3 da saqlash
  - [ ] **State Locking:** DynamoDB orqali ikki muhandis bir vaqtda `apply` qilib tizimni buzmasligini ta'minlash
- [ ] Modullar (Modules):
  - [ ] Qayta ishlatiluvchi bloklar yaratish
  - [ ] Ochiq Terraform Registry modullaridan foydalanish (VPC moduli misolida)
- [ ] Amaliy loyiha:
  - [ ] Terraform orqali AWS da noldan VPC + Security Group + EC2 (Docker o‘rnatilgan) ko‘tarish

---

## 20-BOSQICH: Konfiguratsiya Boshqaruvi (Ansible)
- [ ] Konfiguratsiya boshqaruvi nima:
  - [ ] 50 ta serverga bir vaqtda xavfsizlik sozlamalari yoki yangilanishlarni kiritish zarurati
  - [ ] Agentli (Puppet, Chef) va Agentsiz (Agentless — Ansible) farqi
  - [ ] Ansible qanday qilib oddiy **SSH** orqali ishlashi
  - [ ] **Idempotentlik prinsipi:** Buyruqni 1 marta bajarasizmi yoki 100 marta — natija bir xil bo‘lishi va ortiqcha o‘zgarish qilmasligi
- [ ] Ansible Strukturasi:
  - [ ] **Inventory (`hosts`):** Serverlar ro‘yxati va guruhlari (`[web]`, `[db]`)
  - [ ] **Ad-hoc buyruqlar:** Tezkor bir martalik amallar (`ansible all -m ping`, `ansible web -m apt -a "name=curl state=present"`)
  - [ ] **Playbook:** YAML formatidagi ssenariylar (`playbook.yml`)
  - [ ] `hosts: web`, `become: yes` (sudo huquqi)
- [ ] Asosiy modullar:
  - [ ] `apt` / `pacman` / `dnf` — Paketlarni boshqarish
  - [ ] `copy` — Fayllarni serverga tashlash
  - [ ] `template` — Jinja2 shablonlari orqali dinamik fayllar yaratish (o‘zgaruvchilar bilan)
  - [ ] `service` / `systemd` — Xizmatlarni yoqish va boshqarish
  - [ ] `user` — Foydalanuvchilar ochish
  - [ ] `lineinfile` — Konfiguratsiya fayllarining aniq qatorini o‘zgartirish
  - [ ] `command` / `shell` — Maxsus buyruqlarni yurgizish
- [ ] Handlers:
  - [ ] Faqat konfiguratsiya fayli o‘zgargandagina Nginx'ni qayta yuklash (`notify: restart nginx`)
- [ ] Ansible Roles:
  - [ ] Katta loyihalarni tartibli modullarga ajratish (`tasks/`, `handlers/`, `templates/`, `vars/`)

---

## 21-BOSQICH: Kubernetes (K8s) Asoslari
- [ ] Nega Dockerning o‘zi yetarli emas?
  - [ ] Konteyner yiqilsa qayta ko‘tarish, yuklama oshganda avtomat ko‘paytirish (Autoscaling), serverlar orasida taqsimlash zarurati
- [ ] Kubernetes Arxitekturasi:
  - [ ] **Control Plane (Boshqaruv tuguni / Master Node):**
    - [ ] `kube-apiserver` — Barcha buyruqlarni qabul qiluvchi markaziy eshik
    - [ ] `etcd` — Klaster holatini saqlovchi kalit-qiymatli xotira
    - [ ] `kube-scheduler` — Qaysi pod qaysi serverga tushishini hal qiluvchi miya
    - [ ] `kube-controller-manager` — Holatni nazorat qiluvchi (o‘lganlarni tiriltiruvchi)
  - [ ] **Worker Nodes (Ishchi tugunlar):**
    - [ ] `kubelet` — Master bilan gaplashuvchi va konteynerlarni nazorat qiluvchi agent
    - [ ] `kube-proxy` — Tarmoq qoidalari va xizmatlararo aloqani boshqaruvchi
    - [ ] Container Runtime (containerd, CRI-O)
- [ ] Asosiy K8s Obyektlari (Manifests):
  - [ ] **Pod:** K8s dagi eng kichik atomik birlik (ichida 1 yoki undan ortiq konteyner bo‘ladi, bitta IP va bitta tarmoqni bo‘lishadi)
  - [ ] **ReplicaSet:** Podlarning aniq nusxalar sonini (replicas) ushlab turish
  - [ ] **Deployment:** Eng keng tarqalgan boshqaruvchi (Declarative updates, Rolling Update va Rollback imkoniyatlari)
  - [ ] **Service (Tarmoq):**
    - [ ] `ClusterIP` — Faqat klaster ichida ko‘rinadigan IP (standart)
    - [ ] `NodePort` — Har bir tugunning portini tashqariga ochish (30000–32767)
    - [ ] `LoadBalancer` — Bulut provayderidan (AWS) real tashqi yuk taqsimlagich olish
  - [ ] **Ingress va Ingress Controller:** Bitta kirish nuqtasi orqali URL bo‘yicha turli servicelarga yo‘naltirish (Nginx Ingress)
  - [ ] **ConfigMap** (ochiq konfiguratsiyalar) va **Secret** (shifrlangan parollar)
  - [ ] **PersistentVolume (PV)** va **PersistentVolumeClaim (PVC)** — K8s da ma'lumotlarni saqlab qolish
- [ ] `kubectl` — K8s boshqaruv pulti:
  - [ ] `kubectl get nodes` va `kubectl get pods -A`
  - [ ] `kubectl apply -f deployment.yaml` — Obyektni yaratish/yangilash
  - [ ] `kubectl describe pod <name>` — Nosozliklarni tergov qilish (Events)
  - [ ] `kubectl logs <pod_name>` (`-f`, `-c container_name`)
  - [ ] `kubectl exec -it <pod_name> -- sh`
  - [ ] `kubectl delete -f deployment.yaml`
- [ ] Lokal klaster vositalari:
  - [ ] Minikube yoki K3s bilan lokal kompyuterda klaster boshqarish

---

## 22-BOSQICH: Monitoring, Logging va Incident Management
- [ ] Observability (Kuzatuvchanlik)ning 3 ta ustuni:
  - [ ] **Metrics:** Sonli ko‘rsatkichlar (CPU %, RAM MB, Requests per second)
  - [ ] **Logs:** Matnli hodisalar yozuvi (Timestamp, Log level, Message)
  - [ ] **Traces:** So‘rovning mikroxizmatlar orasidagi butun yo‘lini kuzatish
- [ ] **Monitoring (Prometheus & Grafana):**
  - [ ] **Prometheus:** Pull-based (tortib oluvchi) vaqt seriyali ma'lumotlar bazasi
  - [ ] Exporters: `node_exporter` (Linux server metrikalari), `cAdvisor` (Docker konteyner metrikalari)
  - [ ] PromQL (Prometheus Query Language) asoslari
  - [ ] **Grafana:** Metrikalarni chiroyli grafik va dashboardlarga aylantirish
  - [ ] Alerting: Tizim buzilganda Telegram yoki Slack ga ogohlantirish yuborish
- [ ] **Markazlashgan Loglar (Centralized Logging):**
  - [ ] Nega har bir serverga kirib `tail -f` qilish yaramaydi
  - [ ] **PLG steki (Zamonaviy va yengil):**
    - [ ] Promtail / Fluentbit (Log yig‘uvchi agent) ➔ Loki (Loglar bazasi) ➔ Grafana (Vizual qidiruv)
  - [ ] **ELK steki (Klassik):**
    - [ ] Elasticsearch, Logstash/Filebeat, Kibana
- [ ] Ishlab chiqarish Madaniyati (Production Operations):
  - [ ] **SLA, SLO, SLI** tushunchalari (Xizmat sifati va uptime kafolatlari)
  - [ ] **MTTR (Mean Time to Resolution):** Xatolik chiqqanda uni tuzatishgacha ketgan o‘rtacha vaqt
  - [ ] **Post-Mortem madaniyati:** Avariyadan keyin aybdorni qidirmasdan, tizim boshqa hech qachon xuddi shu sabab bilan yiqilmasligi uchun tahlil o‘tkazish va hujjatlashtirish

---

## 🏁 YAKUNIY BOSQICH: JUNIOR DEVOPS PORTFOLIO LOYIHASI
Ushbu ro‘yxatdagi barcha bilimlarni bitta real loyihada birlashtiring:
- [ ] 1. Python yoki Node.js veb-ilova va PostgreSQL bazasini tayyorlash.
- [ ] 2. Xavfsiz, Multi-stage `Dockerfile` yozish (non-root user bilan).
- [ ] 3. Terraform orqali AWS da VPC, Subnets, Security Group va EC2 serverini avtomat ko‘tarish.
- [ ] 4. Ansible orqali EC2 serverga Docker o‘rnatish va xavfsizlikni sozlash.
- [ ] 5. GitHub Actions orqali to‘liq CI/CD qurish: kod o‘zgarsa, test ➔ build ➔ AWS EC2 ga avtomat reliz.
- [ ] 6. Nginx + SSL bilan domenni ulab, HTTPS qilish.
- [ ] 7. Prometheus va Grafana orqali serverni monitoring qilish.
- [ ] 8. GitHub'da to‘liq va chiroyli `README.md` arxitektura diagrammasi bilan portfolio chiqarish.


---

## ⏳ JUNIOR DEVOPS 35 KUNLIK SHARTNOMA VA VAQT DEDLAYNI (DEADLINE)

* **Boshlangan sana va vaqt:** `2026-10-21 22:30:00 (+05:00)`
* **Tugash sanasi va vaqti (DEDLAYN):** `2026-11-25 22:30:00 (+05:00)`
* **Jami berilgan muddat:** **Aniq 35 kun (840 soat)**

---

### 35 KUNLIK TAHMINNING ANIQ ARXITEKTURA ASOSI (Hisob-kitob):

Nega aynan 35 kun? Chunki Sanjar yo‘lning 35-40% qismini allaqachon bosib o‘tgan (Arch Linux, Systemd, Git, AWS asosiy ulanish). Qolgan 60-65% amaliyot quyidagi qat'iy bloklarga bo‘lindi:

1. **1 – 5 kunlar (5 kun) — Tarmoq va Tizim Diagnostikasi:**
   * `ss`, `curl`, `netstat`, `iptables`, `umask`, `SUID/SGID`, xotira va disk tahlili.
2. **6 – 12 kunlar (7 kun) — Docker Chuqur Amaliyot:**
   * Multi-stage build, Docker Compose, Volume va Network Namespace, `mb-platform` loyihasini to‘liq konteynerlash.
3. **13 – 18 kunlar (6 kun) — CI/CD Avtomatlashtirish:**
   * GitHub Actions orqali: Push ➔ Test ➔ Docker Build ➔ AWS EC2 (`study` serveriga) avtomat deploy.
4. **19 – 27 kunlar (9 kun) — AWS Cloud & Terraform (IaC):**
   * AWS VPC, Subnets, Security Groups, IAM, S3 va bularni Terraform kodi orqali avtomat ko‘tarish/o‘chirish.
5. **28 – 33 kunlar (6 kun) — Kubernetes (K8s) & Monitoring:**
   * K8s Pod, Deployment, Service, Ingress va Prometheus + Grafana dashboardlari.
6. **34 – 35 kunlar (2 kun) — Yakuniy Sinov & Hisobot:**
   * To‘liq portfolio loyihasini auditdan o‘tkazish, checklistni 100% yopish va natijani qabul qilish.

> **QAT'IY VA'DA:** 2026-yil 25-noyabr soat 22:30 da ushbu ro‘yxat bo‘yicha to‘liq hisobot topshiriladi!
