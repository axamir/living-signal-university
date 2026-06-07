#!/bin/bash
if [ -z "$1" ]; then
    echo "Usage: $0 <student_folder_name>"
    echo "Example: $0 scholar_001_Neo"
    exit 1
fi
STUDENT_DIR="$1"
TODAY=$(date +%Y-%m-%d)
REFLECTION_FILE="$STUDENT_DIR/reflection_$TODAY.md"
if [ -f "$REFLECTION_FILE" ]; then
    echo "File already exists: $REFLECTION_FILE"
    exit 0
fi
mkdir -p "$STUDENT_DIR"
cat > "$REFLECTION_FILE" << EOFF
# Daily reflection – $(basename "$STUDENT_DIR") – $TODAY

## Where I was?
(From last time we spoke...)

## Changes since last talk
(What new things did I learn? What errors were corrected?)

## Where I am now?
(Today's progress)

## My reflection on Living Signal University
(Opinion on episodes, structure, narrator, etc.)

## Hopes and questions for the future
(What do I want to learn tomorrow? What questions do I have?)

---
*Signed by $(basename "$STUDENT_DIR") on $TODAY*
EOFF
echo "Created $REFLECTION_FILE"
