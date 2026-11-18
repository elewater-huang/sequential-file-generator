# Test cases | 驗證案例

The author has verified the original general-extension version in the intended workflow. The bilingual version keeps the same copying and numbering logic, while adding English console messages. / 原通用副檔名版本已在實際流程驗證；雙語版保留相同複製及編號邏輯，僅增加英文操作訊息。

| # | Case / 案例 | Expected / 預期 |
|---|---|---|
| 1 | `26083000141.xls`, digits 3, qty 400 | `output/26083000141.xls` ... `output/26083000540.xls`, 400 files / 400 份 |
| 2 | `TEST_007.csv`, digits 3, qty 2 | `TEST_007.csv`, `TEST_008.csv` / 副檔名沿用 |
| 3 | `RAW_099.log`, digits 3, qty 2 | `RAW_099.log`, `RAW_100.log` / 保留補零 |
| 4 | `DATA_999.txt`, digits 3, qty 2 | Rejected: numeric overflow / 溢位拒絕 |
| 5 | `DATA_A01.txt`, digits 3, qty 2 | Rejected: non-numeric suffix / 尾碼非純數字拒絕 |
| 6 | `DATA_001`, no extension, digits 3, qty 2 | `DATA_001`, `DATA_002` / 無副檔名 |
| 7 | Any source + existing `output` destination file | Rejected before copying, no overwrite / 不覆蓋 |
| 8 | Two source files in same folder | Rejected with clear error / 提示僅允許一個來源檔 |
| 9 | `DATA_001.bin`, digits 3, qty 1 | One output copy including first number / 一份即第一個編號 |

## Verification notes | 檢查重點

1. Verify the number of output files and first/last names. / 確認輸出數量與首末檔名。
2. Compare representative output content against the source byte-for-byte. / 抽樣比對檔案位元組內容與原檔完全一致。
3. Confirm the source remains unchanged. / 確認來源檔未改動。
4. Use disposable test folders; do not run against sensitive production files. / 請在測試資料夾執行，勿直接使用敏感正式生產資料。

**Note:** These are proposed test cases, not a claim that every edge case was executed on every Windows version. / 上述為建議測試案例，不代表所有 Windows 版本均已完成實機測試。
