#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Removes duplicate auto-seed script blocks from index.html
"""

import re

filepath = r'c:\Users\Admin\.gemini\antigravity\scratch\ขายของ\index.html'

with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()

# Pattern to match a complete auto-seed script block
pattern = r'<script>\s*\n\s*// Auto-seeded data.*?</script>\s*\n'

# Find all matches
matches = list(re.finditer(pattern, content, re.DOTALL))
print(f"Script blocks found: {len(matches)}")

# Remove ALL blocks
content = re.sub(pattern, '', content, flags=re.DOTALL)

# Verify final state
seed_count_after = content.count('Auto-seeded data')
print(f"Auto-seed blocks after: {seed_count_after}")

# Write back
with open(filepath, 'w', encoding='utf-8') as f:
    f.write(content)

print("\nDONE! File saved successfully.")
