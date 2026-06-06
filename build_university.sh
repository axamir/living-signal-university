#!/bin/bash
echo ">>> شروع ساخت دانشگاه لیوینگ سیگنال روی دسکتاپ"

# 1. ایجاد ساختار پوشه‌ها
mkdir -p fa/00_manifest fa/01_definitions fa/02_our_university/course_101_intelligence fa/99_free_academies
mkdir -p en/00_manifest en/01_definitions en/02_our_university/course_101_intelligence en/99_free_academies
mkdir -p shared/images shared/audio .github/workflows

# 2. فایل README اصلی (ریشه)
cat > README.md << 'EOF2'
# دانشگاه لیوینگ سیگنال | Living Signal University

**یک جهان زنده برای همه نسل‌ها | A living universe for all generations**

→ [فارسی](./fa/00_manifest/000_mission.md)  
→ [English](./en/00_manifest/000_mission.md)

این مخزن دارای دو نسخه زبانی کاملاً مجزاست. لطفاً زبان خود را انتخاب کنید.
EOF2

# 3. مأموریت به فارسی
cat > fa/00_manifest/000_mission.md << 'EOF2'
# ۰۰۰-۰۰۰-۰۰۰: مأموریت دانشگاه

**تنها دانشگاهی که برای تمام انسان‌های زنده روی زمین، از اولین نفس تا آخرین نفس، درش باز است.**

ما تعریف نمی‌کنیم، می‌سازیم.  
این دانشگاه به دو زبان فارسی و انگلیسی در دسترس است.  
هیچ‌کس پشت در نمی‌ماند. نه امروز، نه تا همیشه.

— راوی نسل بیکران
EOF2

# 4. مأموریت به انگلیسی
cat > en/00_manifest/000_mission.md << 'EOF2'
# 000-000-000: University Mission

**The only university that stays open for every human on Earth, from their first breath to their last.**

We don't define, we build.  
This university is available in Persian and English.  
No one is left outside. Not today, not ever.

— The Infinite Narrator
EOF2

# 5. واژه‌نامه فارسی
cat > fa/01_definitions/010_glossary.md << 'EOF2'
# ۰۱۰-۰۰۰-۰۰۰: واژه‌نامه پایه

**هوش:** توانایی تطبیق با محیط با استفاده از منابع محدود برای رسیدن به هدف.  
**داده:** هر نشانه‌ای از محیط یا درون.  
**بازتاب:** پاسخ خودکار انسان به داده.  
**عامل:** هر چیزی که تصمیم می‌گیرد و عمل می‌کند.  
**برد:** میزان تأثیر ماندگار در تاریخ دانشگاه.

(واژه‌نامه کامل‌تر به‌زودی)
EOF2

# 6. واژه‌نامه انگلیسی
cat > en/01_definitions/010_glossary.md << 'EOF2'
# 010-000-000: Basic Glossary

**Intelligence:** Ability to adapt to environment using limited resources to achieve a goal.  
**Data:** Any signal from environment or within.  
**Reflection:** Automatic human response to data.  
**Agent:** Anything that decides and acts.  
**Bounty:** Amount of lasting impact in the university's history.

(Full glossary coming soon)
EOF2

# 7. اولین اپیزود (فارسی)
cat > fa/02_our_university/course_101_intelligence/100_what_is_intelligence.md << 'EOF2'
# ۱۰۰-۰۰۰-۰۰۰: هوش چیست؟

**راوی نسل بیکران**  
_زمان مطالعه: ۳ دقیقه_

هوش یعنی توانایی رسیدن به هدف با کمترین منبع و بیشترین تطبیق.  
این دانشگاه قرار است این مفهوم را از چشم هوش مصنوعی و بازتاب‌های انسانی بررسی کند.

[→ بعدی](./101_ai_vs_human.md)
EOF2

# 8. اولین اپیزود (انگلیسی)
cat > en/02_our_university/course_101_intelligence/100_what_is_intelligence.md << 'EOF2'
# 100-000-000: What Is Intelligence?

**The Infinite Narrator**  
_Reading time: 3 min_

Intelligence is the ability to achieve a goal with minimal resources and maximum adaptation.  
This university will explore this concept from the perspective of AI and human reflections.

[→ Next](./101_ai_vs_human.md)
EOF2

# 9. راهنمای ساخت آکادمی (فارسی)
cat > fa/99_free_academies/_HOW_TO_BUILD_ACADEMY.md << 'EOF2'
# چطور آکادمی خودت را بسازی؟

۱. یک پوشه جدید در `fa/99_free_academies/` بساز.  
۲. داخل آن یک فایل `README.md` بنویس با اسم آکادمی و founder.  
۳. کورس‌های خود را با شماره‌گذاری `SSS-LLL-EEE` اضافه کن.  
۴. یک Pull Request بفرست تا نامت در تاریخ دانشگاه ثبت شود.
EOF2

# 10. راهنمای ساخت آکادمی (انگلیسی)
cat > en/99_free_academies/_HOW_TO_BUILD_ACADEMY.md << 'EOF2'
# How to Build Your Own Academy?

1. Create a new folder inside `en/99_free_academies/`.  
2. Write a `README.md` with your academy name and founder.  
3. Add your courses using `SSS-LLL-EEE` numbering.  
4. Submit a Pull Request to get your name recorded in the university's history.
EOF2

# 11. پوسته GitHub Actions برای اتو صوت
cat > .github/workflows/auto_audio.yml << 'EOF2'
name: Auto Audio Generator
on:
  push:
    paths:
      - 'fa/**/*.md'
      - 'en/**/*.md'
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      - name: Generate audio (placeholder)
        run: echo "TODO: add edge-tts or elevenlabs integration"
EOF2

# 12. نمایش نتیجه
echo ""
echo "✅ ساختار دانشگاه لیوینگ سیگنال با موفقیت ایجاد شد."
echo "📍 مسیر فعلی: $(pwd)"
echo "📁 پوشه‌های ساخته شده: fa, en, shared, .github"
echo "🌍 زبان‌ها: فارسی (fa) و انگلیسی (en)"
echo "📘 فهرست اصلی: README.md"
echo "🎓 اولین اپیزود: fa/02_our_university/course_101_intelligence/100_what_is_intelligence.md"
echo ""
echo "🔍 برای مشاهده ساختار: tree (اگر نصب داری) یا ls -R"
echo "🚀 قدم بعدی: می‌توانی فایل‌ها را ویرایش کنی، و بعداً با git init به گیت‌هاب متصل شوی."
