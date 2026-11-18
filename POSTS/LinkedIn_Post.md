# LinkedIn post | LinkedIn 貼文（中文＋English）

## 中文

**軟體驗證，真的一定要等產線累積幾百份 RAW DATA 嗎？**

在自動化環境裡，每天都會產生大量 RAW DATA 和 LOG FILE。當我們開發生產管理軟體、資料庫或自動匯入機制時，往往也需要大量檔案來驗證流程。

有時候，工程師完成初版程式之後，會說：「先讓產線跑一陣子，等資料累積夠了，我們再來改版。」

我總忍不住想：這究竟是驗證的必要條件，還是工程師終於找到一個可以休息一下的理由？哈！😄

如果檔名本來就有連續編號，我們其實可以先做一件很單純的事：**讓測試檔案自己增生。**

我寫了一個小小的 Windows 批次工具：

把 `26083000141.xls` 放在程式旁邊，輸入「編號位數：3」、「數量：400」，就會在 `output` 裡產生從 `26083000141.xls` 到 `26083000540.xls` 的 400 份檔案。

不限 XLS，CSV、TXT、LOG、BIN 等副檔名都可沿用。完全不必安裝 Python。

這能讓我們更早驗證批次匯入、檔名解析、資料庫歸屬、例外處理，以及大量檔案的管理流程，不必為了測試而等待產線生產。

當然，這 400 份的**檔案內容相同**，所以它是用來驗證檔案處理流程，不是取代真實量測數據的多樣性驗證。

一個不起眼的小工具，換來更短的開發週期，也讓軟體驗證從「等資料」變成「主動設計測試」。

GitHub：［請填入正式儲存庫網址］

#Automation #SoftwareTesting #Manufacturing #DataEngineering #WindowsBatch #資料庫 #自動化

---

## English

**Do we really have to wait for hundreds of production log files before validating new software?**

Automated production lines generate enormous amounts of raw data and log files. When developing manufacturing software, databases, or automated import pipelines, we often need a substantial set of files to verify how the system behaves.

Sometimes, after releasing an initial version, a developer says: “Let the production line run for a while. Once we have enough data, we can improve the software.”

I can't help wondering: is waiting really part of the testing strategy, or just a clever excuse for the engineer to take a short break? 😄

If the files already follow a sequential naming convention, there is a simpler approach: **generate the test files ourselves.**

I created a small Windows batch utility. Place `26083000141.xls` beside the script, enter `3` trailing digits and `400` copies, and it generates 400 files—from `26083000141.xls` to `26083000540.xls`—inside an `output` folder.

It works with CSV, TXT, LOG, BIN, and other extensions, not just XLS. No Python installation required.

This helps us test bulk imports, filename parsing, database mapping, exception handling, and large-volume file workflows without waiting for actual production runs.

One important distinction: the copies have **identical contents**, so they help validate file-handling logic—not the diversity or accuracy of real measurement data.

Sometimes a tiny tool can shorten the development cycle and shift validation from “waiting for data” to **designing better tests**.

GitHub: [Insert published repository URL]

#Automation #SoftwareTesting #Manufacturing #DataEngineering #WindowsBatch
