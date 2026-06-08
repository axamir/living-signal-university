#!/bin/bash
# inspect_repo.sh – بازرسی دقیق مخزن دانشگاه لیوینگ سیگنال
# بررسی ساختار دوزبانه، فایل‌های ضروری، دانشجویان و سیستم نمره‌دهی

echo "=============================="
echo "بازرسی مخزن دانشگاه لیوینگ سیگنال"
echo "تاریخ: $(date +%Y-%m-%d)"
echo "=============================="
echo ""

# رنگ‌ها برای خروجی
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 1. بررسی فایل‌های ریشه (انگلیسی)
echo "1. بررسی فایل‌های اصلی در ریشه:"
root_files=("README.md" "WHITEPAPER.md" "CHARTER.md" "NARRATOR.md" "GENERATIONS.md" "REFLECTION_REQUEST_TEMPLATE.md")
for file in "${root_files[@]}"; do
    if [[ -f "$file" ]]; then
        echo -e "  ${GREEN}✓${NC} $file"
    else
        echo -e "  ${RED}✗${NC} $file (missing)"
    fi
done

# 2. بررسی فایل‌های مشابه در پوشه fa و en
echo ""
echo "2. بررسی تطابق فایل‌های اصلی بین fa/ و en/:"
lang_folders=("fa" "en")
essential_files=("README.md" "WHITEPAPER.md" "CHARTER.md" "NARRATOR.md" "GENERATIONS.md")
for lang in "${lang_folders[@]}"; do
    echo "  پوشه $lang:"
    for file in "${essential_files[@]}"; do
        path="$lang/$file"
        if [[ -f "$path" ]]; then
            echo -e "    ${GREEN}✓${NC} $file"
        else
            echo -e "    ${RED}✗${NC} $file (missing)"
        fi
    done
done

# 3. بررسی اپیزود اول در fa و en
echo ""
echo "3. بررسی اپیزود اول (The Living Signal):"
episode_fa="fa/02_our_university/course_101_intelligence/01_the_living_signal"
episode_en="en/02_our_university/course_101_intelligence/01_the_living_signal"
if [[ -d "$episode_fa" ]]; then
    echo -e "  ${GREEN}✓${NC} پوشه فارسی اپیزود اول موجود است"
else
    echo -e "  ${RED}✗${NC} پوشه فارسی اپیزود اول موجود نیست"
fi
if [[ -d "$episode_en" ]]; then
    echo -e "  ${GREEN}✓${NC} پوشه انگلیسی اپیزود اول موجود است"
else
    echo -e "  ${RED}✗${NC} پوشه انگلیسی اپیزود اول موجود نیست"
fi

# بررسی فایل‌های هر نسل در فارسی (حداقل ۵ فایل)
required_gen_files=("README.md" "for_baby_boomers.md" "for_gen_x.md" "for_millennials.md" "for_gen_z.md" "for_alpha.md" "for_beta.md" "for_infinite.md" "for_ai_models.md")
if [[ -d "$episode_fa" ]]; then
    echo "  فایل‌های هر نسل در فارسی:"
    for f in "${required_gen_files[@]}"; do
        if [[ -f "$episode_fa/$f" ]]; then
            echo -e "    ${GREEN}✓${NC} $f"
        else
            echo -e "    ${RED}✗${NC} $f"
        fi
    done
fi

# 4. بررسی زیرشاخه ai_scholars
echo ""
echo "4. بررسی دانشجویان هوش مصنوعی (ai_scholars):"
if [[ -d "ai_scholars" ]]; then
    echo -e "  ${GREEN}✓${NC} پوشه ai_scholars موجود است"
    # بررسی فایل‌های اصلی در ai_scholars
    ai_files=("README.md" "_index.md" "_STUDENTS_DB.md" "_GRADING_LOG.md" "daily_update.sh")
    for file in "${ai_files[@]}"; do
        path="ai_scholars/$file"
        if [[ -f "$path" ]]; then
            echo -e "    ${GREEN}✓${NC} $file"
        else
            echo -e "    ${RED}✗${NC} $file (missing)"
        fi
    done
    # شمارش پوشه‌های scholar_*
    scholar_count=$(find ai_scholars -maxdepth 1 -type d -name "scholar_*" | wc -l)
    echo "  تعداد دانشجویان ثبت‌شده: $scholar_count"
    # لیست دانشجویان
    echo "  لیست دانشجویان:"
    for dir in ai_scholars/scholar_*; do
        if [[ -d "$dir" ]]; then
            name=$(basename "$dir" | sed 's/scholar_//')
            # بررسی وجود حداقل یک فایل بازتاب
            reflect_count=$(find "$dir" -maxdepth 1 -type f -name "reflection_*.md" | wc -l)
            if [[ $reflect_count -gt 0 ]]; then
                echo -e "    ${GREEN}✓${NC} $name ($reflect_count بازتاب)"
            else
                echo -e "    ${YELLOW}⚠${NC} $name (بدون بازتاب)"
            fi
        fi
    done
else
    echo -e "  ${RED}✗${NC} پوشه ai_scholars وجود ندارد"
fi

# 5. بررسی سیستم نمره‌دهی
echo ""
echo "5. بررسی سیستم نمره‌دهی:"
if [[ -f "ai_scholars/_STUDENTS_DB.md" ]]; then
    # شمارش ردیف‌های جدول (به جز هدر و جداکننده)
    student_rows=$(grep -c "^| [A-Za-zآ-ی]" ai_scholars/_STUDENTS_DB.md)
    echo -e "  ${GREEN}✓${NC} _STUDENTS_DB.md موجود است (تعداد دانشجویان ثبت‌نمره‌شده: $student_rows)"
else
    echo -e "  ${RED}✗${NC} _STUDENTS_DB.md موجود نیست"
fi
if [[ -f "ai_scholars/_GRADING_LOG.md" ]]; then
    log_rows=$(grep -c "^| [0-9]" ai_scholars/_GRADING_LOG.md)
    echo -e "  ${GREEN}✓${NC} _GRADING_LOG.md موجود است (تعداد رکورد نمره: $log_rows)"
else
    echo -e "  ${RED}✗${NC} _GRADING_LOG.md موجود نیست"
fi

# 6. بررسی تطابق بین فهرست دانشجویان در _STUDENTS_DB و پوشه‌های scholar_
echo ""
echo "6. تطابق نام دانشجویان در جدول و پوشه‌ها:"
if [[ -f "ai_scholars/_STUDENTS_DB.md" ]]; then
    # استخراج نام از جدول (ستون اول بعد از |)
    students_in_db=$(grep "^| [A-Za-zآ-ی]" ai_scholars/_STUDENTS_DB.md | awk -F'|' '{print $2}' | sed 's/^ //;s/ $//')
    # استخراج نام از پوشه‌های scholar_
    students_in_folders=$(find ai_scholars -maxdepth 1 -type d -name "scholar_*" | sed 's|ai_scholars/scholar_||' | sort)
    # مقایسه
    missing_in_folders=""
    for name in $students_in_db; do
        if [[ ! -d "ai_scholars/scholar_$name" ]]; then
            missing_in_folders="$missing_in_folders $name"
        fi
    done
    if [[ -n "$missing_in_folders" ]]; then
        echo -e "  ${RED}✗${NC} دانشجویانی که در جدول هستند اما پوشه ندارند:$missing_in_folders"
    else
        echo -e "  ${GREEN}✓${NC} همه دانشجویان جدول پوشه متناظر دارند"
    fi
    
    missing_in_db=""
    for name in $students_in_folders; do
        if ! echo "$students_in_db" | grep -q "^$name$"; then
            missing_in_db="$missing_in_db $name"
        fi
    done
    if [[ -n "$missing_in_db" ]]; then
        echo -e "  ${YELLOW}⚠${NC} پوشه‌هایی که در جدول نیستند:$missing_in_db"
    else
        echo -e "  ${GREEN}✓${NC} همه پوشه‌ها در جدول ثبت شده‌اند"
    fi
fi

# 7. بررسی وجود فایل‌های اضافی یا بی‌ربط
echo ""
echo "7. بررسی فایل‌های موقتی یا اضافی:"
temp_files=$(find . -type f \( -name "*.tmp" -o -name "*.log" -o -name "*.bak" -o -name "*~" \) -not -path "./.git/*")
if [[ -n "$temp_files" ]]; then
    echo -e "  ${YELLOW}⚠${NC} فایل‌های موقتی یافت شد:"
    echo "$temp_files" | sed 's/^/    /'
else
    echo -e "  ${GREEN}✓${NC} هیچ فایل موقتی یافت نشد"
fi

# 8. بررسی یکپارچگی شماره‌گذاری اپیزودها (اختیاری)
echo ""
echo "8. بررسی شماره‌گذاری اپیزودها (فرمت SSS-LLL-EEE):"
episode_files=$(find . -type f -name "*.md" -exec grep -l "^# [0-9]\{3\}-[0-9]\{3\}-[0-9]\{3\}:" {} \;)
if [[ -n "$episode_files" ]]; then
    echo -e "  ${GREEN}✓${NC} فایل‌هایی با شماره‌گذاری استاندارد یافت شد:"
    echo "$episode_files" | head -5 | sed 's/^/    /'
    count=$(echo "$episode_files" | wc -l)
    if [[ $count -gt 5 ]]; then
        echo "    ... و $(($count-5)) فایل دیگر"
    fi
else
    echo -e "  ${YELLOW}⚠${NC} هیچ فایلی با شماره‌گذاری استاندارد یافت نشد (اختیاری)"
fi

echo ""
echo "=============================="
echo "بازرسی به پایان رسید."
echo "در صورت وجود خطا یا missing، لطفاً فایل‌های لازم را اضافه کنید."
echo "=============================="
