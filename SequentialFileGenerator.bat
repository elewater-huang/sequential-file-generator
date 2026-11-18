@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 950 >nul
cd /d "%~dp0"

echo =========================================
echo   通用檔案連號複製工具
echo   Sequential File Generator / 通用檔案連號複製工具
echo =========================================
echo.

rem 尋找同一資料夾內的唯一來源檔：不限副檔名，也支援無副檔名
rem 排除本批次檔與所有子目錄（例如 output）
set "sourceCount=0"
for %%F in ("%~dp0*") do (
    if not exist "%%~fF\" (
        if /I not "%%~fF"=="%~f0" (
            set /a "sourceCount+=1" >nul
            set "source=%%~fF"
            set "base=%%~nF"
            set "ext=%%~xF"
        )
    )
)
if !sourceCount! EQU 0 (
    echo 錯誤：找不到來源檔案。請將來源檔與批次檔放在一起。
    echo ERROR: Source file not found. Put one source file beside this BAT file.
    goto End
)
if !sourceCount! GTR 1 (
    echo 錯誤：找到多個來源檔案，請只保留一個來源檔與本批次檔。
    echo ERROR: Multiple source files found. Keep only one source file and this BAT file.
    goto End
)
echo 來源檔案：!base!!ext!
echo Source file: !base!!ext!
echo.

set "digits="
echo 編號位數 / Number of trailing digits [1-8, example: 3]
set /p "digits=請輸入位數 / Enter digits: "
echo(!digits!|findstr /r "^[1-8]$" >nul
if errorlevel 1 (
    echo 錯誤：位數請輸入 1～8 的整數。
    echo ERROR: Enter an integer from 1 to 8 for trailing digits.
    goto End
)

set "quantity="
echo 複製數量包含起始編號 / Number of output copies, including start [example: 400]
set /p "quantity=請輸入數量 / Enter quantity: "
echo(!quantity!|findstr /r "^[0-9][0-9]*$" >nul
if errorlevel 1 goto BadQuantity
if not "!quantity:~6,1!"=="" goto BadQuantity

rem 移除輸入數量前面的 0，避免批次檔把前導 0 認成八進位
set "qtyText=!quantity!"
:StripQtyZeros
if "!qtyText:~0,1!"=="0" (
    set "qtyText=!qtyText:~1!"
    goto StripQtyZeros
)
if not defined qtyText set "qtyText=0"
set /a "qty=!qtyText!" >nul
if !qty! LSS 1 goto BadQuantity
if !qty! GTR 100000 goto BadQuantity

rem 取來源檔名最後 N 碼，並確認確實有 N 碼且全部為數字
set "suffix=!base:~-%digits%!"
set "prefix=!base:~0,-%digits%!"
set "rest=!suffix!"
set "tooShort="
for /L %%I in (1,1,!digits!) do (
    if defined rest (
        set "rest=!rest:~1!"
    ) else (
        set "tooShort=1"
    )
)
if defined tooShort (
    echo 錯誤：來源檔名長度不足 !digits! 碼。
    echo ERROR: Source filename is shorter than !digits! digits.
    goto End
)
echo(!suffix!|findstr /r "^[0-9][0-9]*$" >nul
if errorlevel 1 (
    echo 錯誤：來源檔名最後 !digits! 碼必須全部是數字。
    echo ERROR: The last !digits! characters of the filename must be digits.
    goto End
)

rem 由字串轉成十進位整數（例如 003 變 3）
set "startText=!suffix!"
:StripStartZeros
if "!startText:~0,1!"=="0" (
    set "startText=!startText:~1!"
    goto StripStartZeros
)
if not defined startText set "startText=0"
set /a "start=!startText!" >nul

rem 指定的編號位數不允許溢位；例如 3 碼最大為 999
set "maxText="
for /L %%I in (1,1,!digits!) do set "maxText=!maxText!9"
set /a "maxNumber=!maxText!" >nul
set /a "endValue=start+qty-1" >nul
if !endValue! GTR !maxNumber! (
    echo 錯誤：末筆編號 !endValue! 超過 !digits! 碼可容納的最大值 !maxNumber!。
    echo ERROR: Final number !endValue! exceeds the !digits!-digit maximum of !maxNumber!.
    echo 請減少數量，或改用更大的位數。
    echo Reduce the quantity or choose a larger digit count.
    goto End
)

rem 預先檢查 output 中是否已有相同檔名，防止覆蓋
set /a "lastIndex=qty-1" >nul
set "collisionName="
for /L %%I in (0,1,!lastIndex!) do (
    set /a "current=start+%%I" >nul
    set "padded=00000000!current!"
    set "newfile=!prefix!!padded:~-%digits%!!ext!"
    if exist "%~dp0output\!newfile!" if not defined collisionName set "collisionName=!newfile!"
)
if defined collisionName (
    echo 錯誤：output 已存在 !collisionName!，為避免覆蓋，本次未複製。
    echo ERROR: output already contains !collisionName!. No files were copied.
    goto End
)

if not exist "%~dp0output\" mkdir "%~dp0output"
if not exist "%~dp0output\" (
    echo 錯誤：無法建立 output 目錄。
    echo ERROR: Could not create the output directory.
    goto End
)

echo.
echo 開始複製 !qty! 份：
echo Copying !qty! files:
echo 第一份：!prefix!!suffix!!ext!
echo First file: !prefix!!suffix!!ext!
set "endPad=00000000!endValue!"
echo 最後一份：!prefix!!endPad:~-%digits%!!ext!
echo Last file: !prefix!!endPad:~-%digits%!!ext!
echo.
set "copied=0"
for /L %%I in (0,1,!lastIndex!) do (
    set /a "current=start+%%I" >nul
    set "padded=00000000!current!"
    set "newfile=!prefix!!padded:~-%digits%!!ext!"
    copy /b "!source!" "%~dp0output\!newfile!" >nul
    if errorlevel 1 (
        echo 複製失敗：!newfile!
        echo ERROR: Failed to copy !newfile!.
        echo 已成功複製 !copied! 份；請檢查磁碟空間或檔案權限。
        echo Successfully copied !copied! files. Check disk space or permissions.
        goto End
    )
    set /a "copied+=1" >nul
)
echo 完成！共 !copied! 份，存放於 output 子目錄。
echo Done. !copied! files saved to the output folder.
goto End

:BadQuantity
echo 錯誤：數量須為 1～100000 的正整數。
echo ERROR: Quantity must be an integer from 1 to 100000.

:End
echo.
pause
endlocal
