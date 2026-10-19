# 06: Docker Deep Dive — Ichki Arxitektura va Amaliyot

Ushbu bo'limda Docker oddiy "sehrli quti" emas, balki Linux yadrosi (Kernel) imkoniyatlarining qat'iy kombinatsiyasi ekanligi amalda isbotlandi.

---

## 1. Konteynerlarning 3 ta Asosiy Ustuni

1. **Linux Namespaces (Izolyatsiya / Ko'rish chegarasi):**
   - `PID Namespace`: Konteyner ichidagi jarayon faqat o'zini `PID 1` deb biladi, xostdagi boshqa jarayonlarni ko'rmaydi.
   - `NET Namespace`: Alohida shaxsiy IP manzil, routing jadvali va tarmoq interfeyslari (`lo`, `eth0`).
   - `MNT Namespace`: Alohida fayl tizimi daraxti (`chroot` / `pivot_root`).

2. **Control Groups (cgroups v2) (Resurs nazorati):**
   - Manzil: `/sys/fs/cgroup/<group_name>/`
   - `memory.max`: Jarayonga ajratilgan qat'iy RAM kvotasi.
   - `memory.swap.max`: Zaxira swap xotirasi chegarasi.
   - **OOM-Killer**: Chegara buzilganda Linux yadrosi jarayonni darhol `SIGKILL` (Exit 137) bilan to'xtatadi.

3. **OverlayFS (Qatlamli fayl tizimi):**
   - `lowerdir`: Read-Only baza (Docker Image qatlami).
   - `upperdir`: Read-Write qatlam (Konteyner o'zgarishlari).
   - `merged`: Ikkalasining birlashgan ko'rinishi.
   - **Copy-on-Write (CoW)**: Baza fayliga teginilmaydi, o'zgartirishlar faqat `upperdir`ga ko'chiriladi.
   - **Whiteout**: Read-Only qatlamdagi faylni o'chirilgandek ko'rsatuvchi maxsus xarakter belgisi.

---

## 2. Docker Daemon va Jarayonlar Zanjiri

```text
[ Docker CLI ] 
      │ (REST API / Socket: /var/run/docker.sock)
      ▼
[ dockerd ] 
      │ (gRPC)
      ▼
[ containerd ] 
      │
      ▼
[ containerd-shim ] ─── (Guardian: dockerd o'chsa ham konteyner tirik qoladi)
      │
      ▼
[ runc ] ─── (OCI runtime: namespaces + cgroups yaratib, chiqib ketadi)
      │
      ▼
[ Konteyner jarayoni ]
```

---

## 3. Xavfsizlik: Host Root vs Container Root

- Konteyner ichidagi `root` (UID 0) — xostdagi UID 0 bilan bir xil son.
- **Himoya:** Docker xavfli Linux Capabilities (`CAP_SYS_ADMIN`, `CAP_SYS_RAWIO`, `CAP_SYS_TIME`) huquqlarini olib qo'yadi.
- Best Practice: Dockerfile ichida xavfsiz alohida `USER` yaratish va `chown` bilan kerakli papkaga huquq berish.

---

## 4. Tarmoq (Networking) va DNS

- Konteynerlar xostga `docker0` (Virtual Switch) va `veth` juftliklari orqali ulanadi.
- Tashqi port yo'naltirish (`-p 8080:80`) — Linux `iptables` NAT (PREROUTING / DOCKER chain) orqali boshqariladi.
- Sukut bo'yicha bridge tarmoqda konteynerlar bir-birini nomi bilan chaqira olmaydi.
- Shaxsiy tarmoq (`docker network create`) ochilganda, Docker ichki DNS server (`127.0.0.11`) orqali servis nomlarini IPga avtomatik o'girib beradi.

---

## 5. Xotira (Storage): Bind Mount vs Named Volume

- **Bind Mount (`-v /host/path:/container/path`)**: Xostdagi fayllarni to'g'ridan-to'g'ri bog'lash. Kodni tahrirlash (development) uchun qulay.
- **Named Volume (`-v volume_name:/container/path`)**: Docker tomonidan boshqariladigan (`/var/lib/docker/volumes/`) xavfsiz va tezkor xotira. Ma'lumotlar bazasi (Persistent storage) uchun standart.
