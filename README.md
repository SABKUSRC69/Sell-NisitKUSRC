# 📊 Sales Dashboard — ระบบสรุปยอดขาย POS

แดชบอร์ดสรุปยอดขายจากระบบ POS รองรับการนำเข้าไฟล์ Excel (`.xlsx`) และแสดงผลสถิติแบบ real-time บนหน้าเว็บเดียว ไม่ต้องใช้ backend

## ✨ ฟีเจอร์หลัก

- 📁 **อัปโหลด Excel** — อ่านไฟล์ `.xlsx` จากระบบ POS และแสดงผลทันที
- 📈 **กราฟสรุปยอด** — Doughnut chart แยกตามช่องทางชำระเงิน และ Bar chart เปรียบเทียบจำนวนออเดอร์
- 📅 **ยอดรายวัน** — ตารางและกราฟ Stacked Bar แสดงรายรับ/คืนเงินแยกตามวันและช่องทาง
- 🔍 **ดูรายการทั้งหมด** — Modal พร้อม pagination, ค้นหา และกรองตามประเภท
- 💾 **บันทึกข้อมูล** — ใช้ `localStorage` เก็บข้อมูลล่าสุดไว้ใช้งานต่อโดยไม่ต้องอัปโหลดใหม่

## 🗂️ โครงสร้างไฟล์

```
ขายของ/
├── index.html          # หน้าหลัก Sales Dashboard
├── pos.payment.xlsx    # ตัวอย่างไฟล์ข้อมูลจาก POS (ไม่บังคับ)
├── README.md           # เอกสารนี้
└── .gitignore
```

## 🚀 วิธีใช้งาน

### เปิดแบบ Local (แนะนำ)

```powershell
# รันด้วย PowerShell script ที่มีให้
.\เปิดเซิร์ฟเวอร์.bat
```

จากนั้นเปิดเบราว์เซอร์ที่ `http://localhost:8080`

> หากรันผ่าน HTTP server ไฟล์ `pos.payment.xlsx` จะถูกโหลดอัตโนมัติหากวางไว้ในโฟลเดอร์เดียวกัน

### เปิดตรงจากไฟล์

ดับเบิลคลิก `index.html` แล้วใช้ปุ่ม **"อัปเดตข้อมูล Excel"** เพื่ออัปโหลดไฟล์ด้วยตนเอง

## ☁️ Deploy บน Cloudflare Pages

1. Push โค้ดขึ้น GitHub repository
2. ไปที่ [Cloudflare Pages](https://pages.cloudflare.com/) → **Create a project** → เชื่อมต่อ GitHub repo
3. ตั้งค่า Build:
   - **Framework preset:** `None`
   - **Build command:** *(เว้นว่าง)*
   - **Output directory:** `/` หรือ `.`
4. คลิก **Save and Deploy** ✅

> ⚠️ เมื่อ deploy แล้ว การโหลด `pos.payment.xlsx` อัตโนมัติจะ**ไม่ทำงาน** เนื่องจากไฟล์ Excel ไม่ควร commit ขึ้น repo  
> ผู้ใช้งานต้องใช้ปุ่ม **"อัปเดตข้อมูล Excel"** เพื่ออัปโหลดไฟล์แทน

## 🛠️ เทคโนโลยีที่ใช้

| ไลบรารี | เวอร์ชัน | วัตถุประสงค์ |
|---------|---------|-------------|
| [Tailwind CSS](https://tailwindcss.com/) | CDN | จัดสไตล์ |
| [Chart.js](https://www.chartjs.org/) | CDN | กราฟ |
| [SheetJS (xlsx)](https://sheetjs.com/) | 0.18.5 | อ่านไฟล์ Excel |
| [Font Awesome](https://fontawesome.com/) | 6.0.0 | ไอคอน |
| [Google Fonts — Prompt](https://fonts.google.com/specimen/Prompt) | — | ฟอนต์ไทย |

## 📝 รูปแบบไฟล์ Excel ที่รองรับ

ไฟล์ `.xlsx` ต้องมีคอลัมน์ดังนี้ (หัวตารางแถวแรก):

| คอลัมน์ | ตัวอย่างค่า | หมายเหตุ |
|--------|------------|---------|
| วัน/เวลา | `30/04/2568 14:32` | วันที่และเวลา |
| หมายเลขออเดอร์ | `Shop/0084` | รหัสรายการ |
| ช่องทางชำระเงิน | `เงินสด`, `เงินโอน`, `Prompt Pay` | |
| ประเภท | `รายรับ`, `คืนเงิน` | |
| ยอดเงิน | `3200` | ตัวเลขบาท |
