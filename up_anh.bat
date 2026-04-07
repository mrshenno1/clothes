@echo off
title Auto Push Cam City Clothing
setlocal enabledelayedexpansion

:: 1. Kiểm tra thay đổi
echo [1/4] Dang kiem tra thay doi...
git add .

:: 2. Nhập ghi chú (Fix lỗi %time% bằng cách bọc kỹ trong dấu ngoặc kép)
set /p msg="Nhap ghi chu update (hoac Enter de mac dinh): "

:: Nếu người dùng không nhập, dùng biến thời gian an toàn
if "%msg%"=="" (
    :: Lấy ngày giờ định dạng an toàn YYYY-MM-DD_HH-mm
    set msg=Update clothing %date% %time%
)

:: Quan trọng: Phải bọc "%msg%" trong dấu ngoặc kép ở lệnh commit
git commit -m "%msg%"

:: Nếu commit thất bại (do không có gì mới) thì dừng lại luôn
if %errorlevel% neq 0 (
    echo [!] Khong co gi moi de commit hoac loi ghi chu.
    pause
    exit
)

:: 3. Kiểm tra kết nối & Push
echo [2/4] Dang kiem tra ket noi GitHub...
git ls-remote origin >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Chua dang nhap. Dang mo trinh duyet de xac thuc...
    git push origin main
) else (
    echo [3/4] Dang day anh len GitHub...
    git push origin main
)

echo.
echo === XONG ROI! ===
pause