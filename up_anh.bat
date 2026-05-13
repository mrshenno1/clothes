@echo off
title Auto Push Cam City Clothing
setlocal enabledelayedexpansion

:: ==========================================
:: BUOC 0: DI CHUYEN DEN THU MUC DU AN
:: Thay duong dan duoi day bang duong dan den thu muc chua .git cua ban
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

:: 3. Kiểm tra kết nối & Push
echo [2/4] Dang kiem tra ket noi GitHub...
git ls-remote origin >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Loi ket noi. Dang thu push de kiem tra...
    git push origin main
) else (
    echo [3/4] Dang day anh len GitHub...
    git push origin main
)

echo.
echo === XONG ROI! ===
pause