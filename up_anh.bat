@echo off
title Auto Push Cam City Clothing
setlocal enabledelayedexpansion

:: ==========================================
:: BUOC 0: DI CHUYEN DEN THU MUC DU AN
:: ==========================================
cd /d "G:\qbx-camcityv21\qbx-camcityv2\txData\Qbox_48738D.base\resources1\fivem-greenscreener\images\clothing"

:: Kiem tra neu van khong thay thu muc .git
if not exist ".git" (
    echo [!] Loi: Khong tim thay thu muc .git tai duong dan nay!
    echo Vui long kiem tra lai duong dan trong file .bat
    pause
    exit /b
)

:: BUOC 1: TU DONG FIX LOI INDEX.LOCK (Neu co)
if exist ".git\index.lock" (
    echo [!] Phat hien file lock ton dong. Dang tu dong xoa...
    del /f /q ".git\index.lock"
)

:: 1. Kiểm tra thay đổi
echo [1/4] Dang kiem tra thay doi...
git add .

:: 2. Nhập ghi chú
set /p msg="Nhap ghi chu update (hoac Enter de mac dinh): "

if "%msg%"=="" (
    set msg=Update clothing %date% %time%
)

:: Thực hiện commit
git commit -m "%msg%"

if %errorlevel% neq 0 (
    echo [!] Khong co gi moi de commit hoac co loi xay ra.
    pause
    exit /b
)

:: 3. Kiểm tra kết nối
echo [2/4] Dang kiem tra ket noi GitHub...
git ls-remote origin >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Khong the ket noi toi GitHub. Vui long kiem tra mang!
    pause
    exit /b
)

:: 4. Đồng bộ dữ liệu mới nhất từ GitHub về trước
echo [3/4] Dang dong bo du lieu moi nhat tu GitHub (git pull)...
git pull --rebase origin main
if %errorlevel% neq 0 (
    echo [!] Co xung dot (conflict) khi dong bo code!
    echo Vui long kiem tra lai thu cong bang tay.
    pause
    exit /b
)

:: 5. Đẩy dữ liệu lên
echo [4/4] Dang day anh len GitHub...
git push origin main

if %errorlevel% neq 0 (
    echo [!] Push that bai!
    pause
    exit /b
)

echo.
echo === XONG ROI! ===
pause