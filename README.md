# XO game flutter X Getx 
XO Game (Tic-Tac-Toe)
เกม XO (หรือ Tic-Tac-Toe) ที่สามารถเล่นได้ได้คนเดียว หรือกับ AI (Player vs AI) โดยใช้เทคนิค Minimax Algorithm 

## วิธีการ Setup และ Run โปรแกรม
1. Clone Repository
2. ติดตั้ง Dependencies
3. Run program  branch develop
   
## วิธีออกแบบโปรแกรม

### Architecture : Model-View-ViewModel(MVVM)  
- Model: จัดการข้อมูลเกม GameHistoryModel() และ GamePreferences() ที่จัดเก็บ history log ของ Player
- View: UI ที่แสดงกระดานและ history board
- VM: Implement logic ในการเช็คเกม และ จัดเก็บข้อมูลแต่ละเกมลง shared preferences

### AI : Minimax Algorithm 
ตรวจสอบการเคลื่อนไหวที่ดีที่สุด
หลักการทำงาน:
1. Maximizing Player (AI): AI จะพยายามหาการเคลื่อนไหวที่ดีที่สุดที่ทำให้ตัวเองชนะ
2. Minimizing Player (Player): ผู้เล่นจะพยายามหาการเคลื่อนไหวที่ทำให้ AI แพ้

ขั้นตอนการทำงาน:
1. สร้างต้นไม้ของการเคลื่อนไหวทั้งหมดที่สามารถเกิดขึ้นได้
2. สำหรับแต่ละโหนดในต้นไม้:
    - หากเป็นโหนดของ AI (Maximizing Player), AI จะเลือกค่าที่สูงสุด (score ที่ดีที่สุด)
    - หากเป็นโหนดของผู้เล่น (Minimizing Player), ผู้เล่นจะเลือกค่าที่ต่ำสุด
3. กลับค่าที่ดีที่สุดจากการคำนวณ

ปล. ในเกม XO มีการเคลื่อนไหวไม่มาก (ขนาดกระดาน 3x3), Minimax Algorithm จะทำงานได้ดีและคำนวณผลลัพธ์ได้เร็ว

### วิธีการเล่นเกม
เกมสามารถเล่นได้สองโหมด:
1. Player vs Player: ผู้เล่นทั้งสองจะสลับกันเล่น X vs O
2. Player vs AI: ผู้เล่นจะเล่นกับ AI ซึ่ง AI จะใช้ Minimax Algorithm ในการคำนวณการเคลื่อนไหวที่ดีที่สุด

ผู้เล่นสามารถเลือกขนาดกระดานที่ต้องการได้ เช่น 3x3 หรือ 4x4 เป็นต้น
เมื่อเกมจบลง (ชนะหรือเสมอ), โปรแกรมจะแสดงผลลัพธ์ที่ชัดเจน และผู้เล่นสามารถเริ่มเกมใหม่ได้

### MAIN Function
1. checkWinner
   ฟังก์ชันนี้จะตรวจสอบว่าผู้เล่นคนใดคนหนึ่งได้ชนะแล้วหรือยัง โดยจะเช็คทั้งในแถว, คอลัมน์, และเส้นทแยงมุม
3. checkDraw
   ฟังก์ชันนี้จะตรวจสอบว่ากระดานเต็มแล้วและไม่มีผู้ชนะ ถ้าเป็นเช่นนั้นจะถือว่าเกมจบลงด้วยผลเสมอ
5. minimaxAlgorithm
   ฟังก์ชันนี้ใช้ Minimax Algorithm ในการคำนวณการเคลื่อนไหวที่ดีที่สุดสำหรับ AI

## Environment
- **Flutter**: Channel stable, 3.22.2, on macOS 14.6.1 23G93 darwin-arm64, locale en-TH
- **Android toolchain**: Develop for Android devices (Android SDK version 35.0.0)
- **Xcode**: Develop for iOS and macOS (Xcode 16.1)
- **Chrome**: Develop for the web
- **Android Studio**: Version 2023.3



<p align="center">
   <img src="https://github.com/user-attachments/assets/b27cd2d8-70b3-4857-9537-ae3019b70d48" alt="Screenshot 2" width="25%" style="margin-right: 10px;">
   <img src="https://github.com/user-attachments/assets/f9876d74-bb0a-4dd3-93c0-2b4c71a2f025" alt="Screenshot 2" width="25%" style="margin-right: 10px;">
     <img src="https://github.com/user-attachments/assets/3f8cbe59-e81d-435e-9c81-ffae09332385" alt="Screenshot 2" width="25%" style="margin-right: 10px;">
  <img src="https://github.com/user-attachments/assets/270110f6-082c-49b7-875e-96c760877827" alt="Screenshot 3" width="25%">
    <img src="https://github.com/user-attachments/assets/31a86597-6b2a-4b44-836d-e4f75ba78acd" alt="Screenshot 3" width="25%">
</p>
