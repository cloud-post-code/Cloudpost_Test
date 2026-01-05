#!/usr/bin/env python3
"""
Script to parse SQL dump and extract table definitions, columns, and relationships
"""

import re
from collections import defaultdict
from typing import Dict, List, Tuple

def parse_table_name(create_table_line: str) -> str:
    """Extract table name from CREATE TABLE statement"""
    match = re.search(r'CREATE TABLE `([^`]+)`', create_table_line, re.IGNORECASE)
    return match.group(1) if match else None

def parse_columns(table_content: str) -> List[Dict]:
    """Parse column definitions from table content"""
    columns = []
    # Match column definitions: `column_name` type [constraints] [COMMENT 'comment']
    column_pattern = r'`([^`]+)`\s+([^,\n]+?)(?:,\s*$|,\s*\n|$)'
    
    lines = table_content.split('\n')
    in_columns = False
    current_column = None
    
    for line in lines:
        line = line.strip()
        if not line or line.startswith('--'):
            continue
            
        # Match column definition
        col_match = re.match(r'`([^`]+)`\s+([^,]+?)(?:,\s*$|$)', line)
        if col_match:
            col_name = col_match.group(1)
            col_def = col_match.group(2).strip()
            
            # Extract data type
            type_match = re.match(r'(\w+(?:\([^)]+\))?)', col_def)
            col_type = type_match.group(1) if type_match else col_def.split()[0]
            
            # Check for PRIMARY KEY
            is_primary = 'PRIMARY KEY' in col_def or 'NOT NULL AUTO_INCREMENT' in col_def
            
            # Check for NOT NULL
            is_not_null = 'NOT NULL' in col_def
            
            # Extract comment if present
            comment_match = re.search(r"COMMENT\s+['\"]([^'\"]+)['\"]", col_def, re.IGNORECASE)
            comment = comment_match.group(1) if comment_match else None
            
            columns.append({
                'name': col_name,
                'type': col_type,
                'full_definition': col_def,
                'is_primary': is_primary,
                'is_not_null': is_not_null,
                'comment': comment
            })
        elif 'PRIMARY KEY' in line.upper() and '`' in line:
            # Handle PRIMARY KEY on separate line
            pk_match = re.search(r'`([^`]+)`', line)
            if pk_match:
                pk_col = pk_match.group(1)
                for col in columns:
                    if col['name'] == pk_col:
                        col['is_primary'] = True
    
    return columns

def identify_foreign_keys(columns: List[Dict], table_name: str) -> List[str]:
    """Identify potential foreign key relationships based on column naming"""
    fk_relationships = []
    
    # Common foreign key patterns
    fk_patterns = [
        # Pattern: tableprefix_id -> tbl_tableprefix or tbl_tableprefixs
        (r'(\w+)_id$', lambda m: [f"tbl_{m.group(1)}", f"tbl_{m.group(1)}s"]),
        # Pattern: tableprefix_record_id -> tbl_tableprefix or tbl_tableprefixs
        (r'(\w+)_record_id$', lambda m: [f"tbl_{m.group(1)}", f"tbl_{m.group(1)}s"]),
        # Pattern: prefix1_prefix2_id -> tbl_prefix1_prefix2s or tbl_prefix1_prefix2
        (r'(\w+)_(\w+)_id$', lambda m: [f"tbl_{m.group(1)}_{m.group(2)}s", f"tbl_{m.group(1)}_{m.group(2)}", f"tbl_{m.group(1)}s_{m.group(2)}s"]),
    ]
    
    # Special mappings for common FK patterns
    special_mappings = {
        r'user_id$': ['tbl_users'],
        r'admin_id$': ['tbl_admin'],
        r'order_id$': ['tbl_orders'],
        r'product_id$': ['tbl_products', 'tbl_seller_products'],
        r'selprod_id$': ['tbl_seller_products'],
        r'seller_id$': ['tbl_users'],  # sellers are users
        r'shop_id$': ['tbl_shops'],
        r'category_id$': ['tbl_product_categories'],
        r'brand_id$': ['tbl_brands'],
        r'coupon_id$': ['tbl_coupons'],
        r'promotion_id$': ['tbl_promotions'],
        r'lang_id$': ['tbl_languages'],
        r'country_id$': ['tbl_countries'],
        r'state_id$': ['tbl_states'],
        r'currency_id$': ['tbl_currency'],
        r'addr_id$': ['tbl_addresses'],
    }
    
    for col in columns:
        col_name = col['name']
        
        # Skip if it's a primary key (unless it's a composite FK)
        if col['is_primary'] and not col_name.endswith('_record_id'):
            continue
        
        # Check special mappings first
        found_mapping = False
        for pattern, targets in special_mappings.items():
            if re.match(pattern, col_name):
                for target in targets:
                    fk_relationships.append((col_name, target))
                found_mapping = True
                break
        
        if found_mapping:
            continue
            
        # Check common FK patterns
        for pattern, extractor in fk_patterns:
            match = re.match(pattern, col_name)
            if match:
                candidates = extractor(match)
                for candidate in candidates:
                    fk_relationships.append((col_name, candidate))
                break
    
    return fk_relationships

def categorize_table(table_name: str) -> str:
    """Categorize table into functional area"""
    table_lower = table_name.lower()
    
    # Explicit mappings for specific tables
    explicit_mappings = {
        'tbl_countries': 'Configuration & Settings',
        'tbl_countries_lang': 'Configuration & Settings',
        'tbl_zones': 'Configuration & Settings',
        'tbl_zones_lang': 'Configuration & Settings',
        'tbl_sms_templates': 'Notifications & Communications',
        'tbl_sms_archives': 'Notifications & Communications',
        'tbl_rewards_on_purchase': 'Marketing & Promotions',
        'tbl_social_platforms': 'Marketing & Promotions',
        'tbl_social_platforms_lang': 'Marketing & Promotions',
        'tbl_failed_login_attempts': 'Security & Moderation',
        'tbl_questions': 'Polling & Questionnaires',
        'tbl_questions_lang': 'Polling & Questionnaires',
        'tbl_user_collections': 'User Management',
    }
    
    if table_name in explicit_mappings:
        return explicit_mappings[table_name]
    
    # Security & Moderation (check early to catch security-related tables)
    if any(x in table_lower for x in ['abusive', 'unique_check_failed']):
        return 'Security & Moderation'
    
    # Tax Management (check before generic patterns)
    if any(x in table_lower for x in ['tax_', 'taxcat', 'taxrule', 'taxstr']):
        return 'Tax Management'
    
    # Shopping Cart & User Activity
    if any(x in table_lower for x in ['abandoned_cart', 'empty_cart']):
        return 'Shopping Cart & User Activity'
    
    # SEO & URL Management
    if any(x in table_lower for x in ['meta_tag', 'url_rewrite']):
        return 'SEO & URL Management'
    
    # System Utilities (check before generic patterns)
    if any(x in table_lower for x in ['calculative_data', 'layout_template', 'time_slot', 'tool_tip', 'tracking_courier', 'upc_code']):
        return 'System Utilities'
    if 'recommendation_activity' in table_lower and 'browsing' in table_lower:
        return 'System Utilities'
    
    # Product Discovery & Search
    if any(x in table_lower for x in ['filter', 'search_item', 'tag']):
        if 'collection' not in table_lower or 'collection_to_records' in table_lower:
            return 'Product Discovery & Search'
    
    # Collections (part of Product Discovery & Search)
    if 'collection' in table_lower:
        return 'Product Discovery & Search'
    
    # Polling & Questionnaires
    if any(x in table_lower for x in ['polling', 'questionnaire', 'qbank', 'question_to_answers']):
        return 'Polling & Questionnaires'
    if 'question' in table_lower and 'bank' in table_lower:
        return 'Polling & Questionnaires'
    
    # Content & Media Management
    if any(x in table_lower for x in ['attached_file', 'slide', 'policy_point', 'testimonial', 'success_stor']):
        return 'Content & Media Management'
    
    # User Management
    if any(x in table_lower for x in ['user', 'admin', 'address', 'auth', 'login', 'password', 'cookie']):
        if 'seller' not in table_lower and 'product' not in table_lower and 'order' not in table_lower:
            return 'User Management'
    
    # Product Management
    if any(x in table_lower for x in ['product', 'category', 'brand', 'attribute', 'option', 'specification', 'digital', 'stock', 'selprod']):
        return 'Product Management'
    
    # Order Management
    if any(x in table_lower for x in ['order', 'payment', 'shipment', 'shipping', 'cancel', 'return']):
        return 'Order Management'
    
    # Seller/Vendor Management
    if any(x in table_lower for x in ['seller', 'vendor', 'shop', 'commission']):
        if 'product' not in table_lower and 'order' not in table_lower:
            return 'Seller/Vendor Management'
    
    # Content Management
    if any(x in table_lower for x in ['blog', 'content', 'page', 'banner', 'navigation', 'faq', 'help']):
        return 'Content Management'
    
    # Marketing & Promotions
    if any(x in table_lower for x in ['coupon', 'promotion', 'badge', 'ad', 'affiliate']):
        return 'Marketing & Promotions'
    
    # Configuration & Settings
    if any(x in table_lower for x in ['config', 'setting', 'language', 'currency', 'country', 'state', 'plugin', 'zone']):
        return 'Configuration & Settings'
    
    # Notifications & Communications
    if any(x in table_lower for x in ['notification', 'email', 'message', 'sms']):
        return 'Notifications & Communications'
    
    # Ratings & Reviews
    if any(x in table_lower for x in ['rating', 'review', 'feedback']):
        return 'Ratings & Reviews'
    
    # Reports & Logging
    if any(x in table_lower for x in ['report', 'log', 'history', 'cron', 'analytics', 'updated_record']):
        return 'Reports & Logging'
    
    return 'Other'

def parse_sql_file(filename: str) -> Dict:
    """Parse SQL file and extract all table information"""
    with open(filename, 'r', encoding='utf-8') as f:
        content = f.read()
    
    tables = {}
    current_table = None
    current_content = []
    in_table = False
    
    lines = content.split('\n')
    i = 0
    
    while i < len(lines):
        line = lines[i]
        
        # Check for CREATE TABLE
        if re.search(r'CREATE TABLE', line, re.IGNORECASE):
            # Save previous table if exists
            if current_table and current_content:
                table_content = '\n'.join(current_content)
                columns = parse_columns(table_content)
                category = categorize_table(current_table)
                fks = identify_foreign_keys(columns, current_table)
                
                tables[current_table] = {
                    'columns': columns,
                    'category': category,
                    'foreign_keys': fks,
                    'raw_content': table_content
                }
            
            # Start new table
            current_table = parse_table_name(line)
            current_content = [line]
            in_table = True
            
        elif in_table:
            current_content.append(line)
            # Check if table definition ends
            if line.strip().endswith(';') and ('ENGINE' in line.upper() or 'CHARSET' in line.upper()):
                in_table = False
        
        i += 1
    
    # Don't forget the last table
    if current_table and current_content:
        table_content = '\n'.join(current_content)
        columns = parse_columns(table_content)
        category = categorize_table(current_table)
        fks = identify_foreign_keys(columns, current_table)
        
        tables[current_table] = {
            'columns': columns,
            'category': category,
            'foreign_keys': fks,
            'raw_content': table_content
        }
    
    return tables

if __name__ == '__main__':
    sql_file = 'sample.sql'
    print(f"Parsing {sql_file}...")
    tables = parse_sql_file(sql_file)
    
    print(f"\nFound {len(tables)} tables")
    print("\nTables by category:")
    categories = defaultdict(list)
    for table_name, info in tables.items():
        categories[info['category']].append(table_name)
    
    for category, table_list in sorted(categories.items()):
        print(f"\n{category} ({len(table_list)} tables):")
        for table in sorted(table_list):
            print(f"  - {table}")
    
    # Save parsed data as JSON for use in documentation generation
    import json
    # Convert to JSON-serializable format
    tables_json = {}
    for table_name, info in tables.items():
        tables_json[table_name] = {
            'columns': info['columns'],
            'category': info['category'],
            'foreign_keys': info['foreign_keys']
        }
    
    with open('parsed_tables.json', 'w', encoding='utf-8') as f:
        json.dump(tables_json, f, indent=2, ensure_ascii=False)
    
    print(f"\nParsed data saved to parsed_tables.json")
