#!/bin/bash

echo "=== 2-BOSQICH: I/O REDIRECTION VA QUVURLAR AUDITI ==="
passed=true

# 1. success.log tekshiruvi (stdout)
if [ ! -f "success.log" ]; then
    echo "❌ [FAIL] 1. 'success.log' fayli topilmadi!"
    echo "   Maslahat: ./stream-producer.py ning stdout (1) oqimini success.log ga yo'naltiring."
    passed=false
else
    SUCCESS_COUNT=$(grep -c "\[SUCCESS\]" success.log 2>/dev/null)
    ERROR_COUNT_IN_SUCCESS=$(grep -c "\[ERROR\]" success.log 2>/dev/null)
    if [ "$SUCCESS_COUNT" -eq 10 ] && [ "$ERROR_COUNT_IN_SUCCESS" -eq 0 ]; then
        echo "✅ [PASS] 1. 'success.log' toza ajratildi (10 ta muvaffaqiyatli tranzaksiya, 0 ta xato)."
    else
        echo "❌ [FAIL] 1. 'success.log' noto'g'ri: $SUCCESS_COUNT ta success, lekin $ERROR_COUNT_IN_SUCCESS ta error aralashgan!"
        passed=false
    fi
fi

# 2. errors.log tekshiruvi (stderr)
if [ ! -f "errors.log" ]; then
    echo "❌ [FAIL] 2. 'errors.log' fayli topilmadi!"
    echo "   Maslahat: ./stream-producer.py ning stderr (2) oqimini errors.log ga yo'naltiring (2> errors.log)."
    passed=false
else
    ERR_COUNT=$(grep -c "\[ERROR\]" errors.log 2>/dev/null)
    SUCCESS_IN_ERR=$(grep -c "\[SUCCESS\]" errors.log 2>/dev/null)
    if [ "$ERR_COUNT" -eq 5 ] && [ "$SUCCESS_IN_ERR" -eq 0 ]; then
        echo "✅ [PASS] 2. 'errors.log' toza ajratildi (5 ta xato, 0 ta success)."
    else
        echo "❌ [FAIL] 2. 'errors.log' noto'g'ri: $ERR_COUNT ta error, $SUCCESS_IN_ERR ta success aralashgan!"
        passed=false
    fi
fi

# 3. error_summary.txt tekshiruvi (Pipeline sort | uniq -c)
if [ ! -f "error_summary.txt" ]; then
    echo "❌ [FAIL] 3. 'error_summary.txt' fayli topilmadi!"
    echo "   Maslahat: errors.log ni sort va uniq -c quvurlaridan o'tkazib, error_summary.txt ga yozing."
    passed=false
else
    if grep -q "3 \[ERROR\] DB_TIMEOUT" error_summary.txt && grep -q "1 \[ERROR\] AUTH_FAILED" error_summary.txt; then
        echo "✅ [PASS] 3. 'error_summary.txt' tahlili to'g'ri (xatoliklar sort va uniq -c bilan hisoblandi)."
    else
        echo "❌ [FAIL] 3. 'error_summary.txt' dagi hisobot noto'g'ri! (sort errors.log | uniq -c > error_summary.txt)"
        passed=false
    fi
fi

# 4. all_traffic.log tekshiruvi (Birlashgan oqim: 2>&1 yoki tee)
if [ ! -f "all_traffic.log" ]; then
    echo "❌ [FAIL] 4. 'all_traffic.log' fayli topilmadi!"
    echo "   Maslahat: stdout va stderr ni birlashtirib (2>&1) all_traffic.log ga yo'naltiring."
    passed=false
else
    TOTAL_LINES=$(wc -l < all_traffic.log 2>/dev/null | tr -d ' ')
    if [ "$TOTAL_LINES" -eq 15 ]; then
        echo "✅ [PASS] 4. 'all_traffic.log' birlashgan oqimi to'g'ri (jami 15 ta qator saqlangan)."
    else
        echo "❌ [FAIL] 4. 'all_traffic.log' to'liq emas (15 ta qator bo'lishi kerak, sizda: $TOTAL_LINES ta)!"
        passed=false
    fi
fi

echo ""
if [ "$passed" = true ]; then
    echo "=========================================================="
    echo "🎉 TABRIKLAYMAN! 2-BOSQICH MUVAFFAQIYATLI YAKUNLANDI!"
    echo "=========================================================="
    echo "Siz Linux'da oqimlarni ajratish (stdout, stderr), qayta yo'naltirish (2>, >>)"
    echo "va quvurlar zanjirini (| sort | uniq) professional darajada egalladingiz."
    echo ""
    echo "Amaliyotni Git'ga saqlashni unutmang:"
    echo "  git add ."
    echo "  git commit -m 'done: 02-io-redirection/stream-filtering'"
    echo "  git push"
    exit 0
else
    echo "⚠️ Barcha shartlar to'liq bajarilishi kerak. HANDBOOK.md ni ko'rib, qaytadan urinib ko'ring."
    exit 1
fi
