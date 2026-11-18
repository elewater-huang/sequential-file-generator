# Sequential File Generator | 檔案連號複製工具

A lightweight **Windows batch utility** for creating many sequentially named copies of a single file. **Any file extension is supported** (including files with no extension). No Python or external dependency is required.

這是一個輕量的 **Windows 批次檔工具**：只要提供一個來源檔案，就能批次複製出大量「檔名編號遞增」的檔案。**不限副檔名**（也支援無副檔名），不必安裝 Python 或任何外部套件。

## Why I built it | 開發緣起

### 中文

在自動化生產環境中，每天都會累積大量等待整理與分析的 RAW DATA、LOG FILE。設計自動化管理軟體、檔案匯入流程或資料庫時，也需要足夠的測試檔案來驗證運作是否正確。

有時工程師完成軟體初版後，會請產線持續運轉一段時間，等累積足夠的資料再進行下一輪修改。（當然，也可能是工程師終於找到一個能休息一下的理由，哈！）

若資料檔名本來就包含連續的流水編號，就不必為了測試檔案處理流程，而等待實際生產累積數百、數千個檔案。這個小工具可以從一個來源檔案，快速建立大量不同檔名的測試副本，用來檢查檔案偵測、批次匯入、命名規則、資料庫歸屬、例外處理等流程。目標是縮短開發與驗證週期，讓工程師更早發現問題。

### English

An automated production environment can generate countless raw data and log files every day. When building automation software, file-import pipelines, or production databases, developers often need a substantial number of files to verify that the workflow behaves as intended.

Sometimes, after finishing the first software version, an engineer asks the production line to keep running until enough data has accumulated for the next round of improvements. (Or perhaps it's a convenient excuse for a well-deserved break. 😄)

When files already use sequential numeric identifiers, there is no need to wait for hundreds or thousands of real production files just to test file-handling behavior. This small utility quickly generates a batch of copies with different sequential filenames. It is useful for checking file discovery, batch imports, filename parsing, database attribution, and error handling, allowing developers to identify issues earlier and shorten validation cycles.

## Quick start | 使用方法

1. Download **`SequentialFileGenerator.bat`**. 下載 `SequentialFileGenerator.bat`。
2. Put **one source file** and this batch file in the same folder. 將批次檔與**一個來源檔**放在同一資料夾。
3. Double-click the batch file. 雙擊執行。
4. Enter the **number of trailing digits**. 輸入檔名最後的**編號位數**。
5. Enter the **number of output copies**. 輸入**複製數量**（含起始編號）。
6. Find the results in the newly created **`output`** folder. 在自動建立的 `output` 子目錄取得結果。

### Example | 範例

**Source / 來源：** `26083000141.xls`  
**Trailing digits / 位數：** `3`  
**Copies / 數量：** `400`

```text
work_folder/
├─ SequentialFileGenerator.bat
├─ 26083000141.xls
└─ output/
   ├─ 26083000141.xls
   ├─ 26083000142.xls
   ├─ 26083000143.xls
   ├─ ...
   ├─ 26083000539.xls
   └─ 26083000540.xls
```

**400 files total, from `141` through `540`, inclusive.**  
**共 400 份，編號由 `141` 到 `540`，包含起始檔。**

The *contents are identical* to the source; **only filenames change**.  
**內容與來源檔完全相同；只有檔名改變。**

### Supported extensions | 副檔名

`.xls`, `.xlsx`, `.csv`, `.txt`, `.log`, `.jpg`, `.bin`, other extensions, and files without extensions.  
不限上述副檔名；工具直接沿用來源檔案的副檔名，不進行格式轉換。

## Behavior & safeguards | 行為與保護

| 中文 | English |
|---|---|
| 來源資料夾只能有一個來源檔和本批次檔 | The working folder must contain exactly one source file and this BAT file |
| 自動讀取副檔名並沿用 | Preserves the original extension automatically |
| 只遞增「主檔名」最後指定的數字 | Increments only the final numeric characters of the filename stem |
| 位數可輸入 1–8 | Trailing digit count: 1–8 |
| 數量可輸入 1–100,000 | Copy count: 1–100,000 |
| 自動補零，並阻止編號溢位 | Keeps zero padding and rejects numeric overflow |
| 複製前檢查目標檔是否已存在 | Pre-checks filename collisions before copying |
| 不修改、不移動來源檔案 | Does not modify or move the source file |
| 複製失敗時提示成功份數 | Reports completed copies if a copy operation fails |

**Compatibility / 系統：** Windows CMD, designed for Windows 7 and newer. The BAT file is encoded as **Traditional Chinese Big5 (CP950)**, sets `chcp 950`, and displays Chinese and English messages. For reliable filename handling, avoid exclamation marks (`!`) in the source path or filename because Windows delayed expansion treats them specially.

**重要 / Important:** The trailing digits must be at the **end of the filename before its extension**, such as `TEST_001.csv`. / 要遞增的數字必須位於副檔名前的主檔名末尾，如 `TEST_001.csv`。

## What it can—and cannot—validate | 驗證範圍

**Suitable / 適合：**
- File discovery, count checks, filename parsing / 檔案掃描、數量檢查與檔名解析。
- Bulk importing and file-moving workflows / 大量匯入與檔案搬移流程。
- Database mapping and exception handling based on filenames / 以檔名為依據的資料庫歸屬、例外處理。
- Preliminary stress and regression testing of file-management logic / 檔案管理流程的初步壓力測試與回歸測試。

**Not sufficient / 不足以：**
- Validate measurement accuracy, genuine data variability, or statistical conclusions / 驗證量測正確性、真實資料多樣性或統計結論。
- Test uniqueness or de-duplication rules that depend on file contents or checksums / 驗證依檔案內容或雜湊值判斷重複的系統。
- Replace validation with real production data / 完全取代真實生產資料的驗證。

**Always use non-sensitive synthetic/sample data for public demonstrations. Never publish proprietary production logs or customer data.**  
**公開展示請使用不含敏感資訊的測試檔，勿上傳公司 RAW DATA、LOG 或客戶資料。**

## Files | 專案檔案

- `SequentialFileGenerator.bat` — bilingual batch utility / 中英雙語批次工具。
- `README.md` — bilingual documentation / 中英文說明。
- `TEST_CASES.md` — suggested verification cases / 建議驗證項目。

## License | 授權

MIT License. See `LICENSE`.
