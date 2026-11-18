# Facebook post | Facebook 貼文（中文＋English）

## 中文

**工程師寫完第一版軟體之後，最喜歡說的一句話是什麼？**

「先讓產線跑一段時間，等 RAW DATA 跟 LOG FILE 累積夠多，再來驗證、改版。」

聽起來很合理。但我有時候會懷疑，這是不是工程師光明正大休息幾天的好理由？哈哈！🤣

自動化環境裡，一天就有無數檔案進進出出。開發管理軟體或資料庫時，確實需要大量測試檔案，但不見得每次都得慢慢等產線生出來。

我寫了個簡單的 Windows 批次檔：只要丟一份檔案進去，例如 `26083000141.xls`，再輸入「最後幾碼要遞增：3」、「總共複製幾份：400」，程式就會自動建立 `output` 資料夾，產生從 `26083000141.xls` 到 `26083000540.xls` 的 400 份檔案。

不限定 XLS！CSV、TXT、LOG，甚至沒有副檔名的檔案也可以。不需要 Python。

這些檔案內容都一樣，只有檔名不同。目的不是假造量測結果，而是先把軟體的檔案匯入、辨識、資料庫處理與例外流程測紮實。

讓產線繼續忙產線的，工程師也不必乾等資料。小工具，解決一件常見的麻煩事。😁

GitHub：［請填入正式儲存庫網址］

#自動化 #程式設計 #軟體驗證 #Windows批次檔 #工程師日常

---

## English

**What does a software engineer say after finishing version one?**

“Let the production line run for a while so we can collect enough raw data and log files. Then we'll test and improve it.”

Sounds reasonable. But sometimes I wonder whether that's also a perfect excuse for a few days of rest. 😄

In an automated environment, file-management and database workflows need realistic stress tests. Yet we don't always have to wait for the production line to generate hundreds of test filenames.

So I made a tiny Windows batch tool: start with `26083000141.xls`, enter `3` trailing digits and `400` copies, and get 400 sequentially named files in the `output` folder—ending at `26083000540.xls`.

XLS is just one example. CSV, TXT, LOG, other extensions, and even extensionless files work too. No Python needed.

The contents stay identical; only filenames change. This is for validating import and file-management logic, **not** for faking or replacing real measurement data.

A little utility that saves a lot of waiting. 😁

GitHub: [Insert published repository URL]

#Automation #SoftwareTesting #Manufacturing #WindowsBatch
