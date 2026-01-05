#!/usr/bin/env python3
"""
Generate comprehensive database documentation from parsed table data
"""

import json
import re
from collections import defaultdict

def normalize_table_name(table_name: str) -> str:
    """Convert table name to node ID for mermaid"""
    # Remove tbl_ prefix and convert to camelCase
    name = table_name.replace('tbl_', '')
    # Convert snake_case to camelCase
    parts = name.split('_')
    return ''.join(word.capitalize() for word in parts)

def get_primary_table_name(fk_target: str) -> str:
    """Try to find the actual primary table name"""
    # Common mappings
    mappings = {
        'tbl_user': 'tbl_users',
        'tbl_order': 'tbl_orders',
        'tbl_product': 'tbl_products',
        'tbl_seller': 'tbl_sellers',
        'tbl_shop': 'tbl_shops',
        'tbl_category': 'tbl_product_categories',
        'tbl_brand': 'tbl_brands',
        'tbl_admin': 'tbl_admin',
        'tbl_address': 'tbl_addresses',
        'tbl_coupon': 'tbl_coupons',
        'tbl_promotion': 'tbl_promotions',
        'tbl_language': 'tbl_languages',
        'tbl_currency': 'tbl_currency',
        'tbl_country': 'tbl_countries',
        'tbl_state': 'tbl_states',
    }
    return mappings.get(fk_target, fk_target)

def build_relationships(tables: dict) -> dict:
    """Build relationship map between tables"""
    relationships = defaultdict(set)
    
    # Map common FK patterns to actual table names
    fk_to_table_map = {
        'tbl_users': 'tbl_users',
        'tbl_user': 'tbl_users',
        'tbl_admin': 'tbl_admin',
        'tbl_orders': 'tbl_orders',
        'tbl_order': 'tbl_orders',
        'tbl_products': 'tbl_products',
        'tbl_product': 'tbl_products',
        'tbl_seller_products': 'tbl_seller_products',
        'tbl_selprod': 'tbl_seller_products',
        'tbl_shops': 'tbl_shops',
        'tbl_shop': 'tbl_shops',
        'tbl_product_categories': 'tbl_product_categories',
        'tbl_category': 'tbl_product_categories',
        'tbl_brands': 'tbl_brands',
        'tbl_brand': 'tbl_brands',
        'tbl_coupons': 'tbl_coupons',
        'tbl_coupon': 'tbl_coupons',
        'tbl_promotions': 'tbl_promotions',
        'tbl_promotion': 'tbl_promotions',
        'tbl_languages': 'tbl_languages',
        'tbl_lang': 'tbl_languages',
        'tbl_countries': 'tbl_countries',
        'tbl_country': 'tbl_countries',
        'tbl_states': 'tbl_states',
        'tbl_state': 'tbl_states',
        'tbl_currency': 'tbl_currency',
        'tbl_addresses': 'tbl_addresses',
        'tbl_address': 'tbl_addresses',
        'tbl_badges': 'tbl_badges',
        'tbl_badge': 'tbl_badges',
    }
    
    for table_name, table_info in tables.items():
        for fk in table_info['foreign_keys']:
            fk_column, target_table = fk
            
            # Try to find actual table
            actual_target = None
            
            # First check direct match
            if target_table in tables:
                actual_target = target_table
            # Then check our mapping
            elif target_table in fk_to_table_map:
                mapped = fk_to_table_map[target_table]
                if mapped in tables:
                    actual_target = mapped
            # Try variations
            else:
                # Try to find by checking all variations
                variations = [
                    target_table,
                    target_table.replace('s', '') if target_table.endswith('s') else target_table + 's',
                    get_primary_table_name(target_table),
                ]
                for var in variations:
                    if var in tables:
                        actual_target = var
                        break
            
            if actual_target and actual_target != table_name:
                relationships[table_name].add((actual_target, fk_column))
    
    # Add some explicit common relationships for better diagram
    explicit_relationships = {
        'tbl_order_products': ['tbl_orders', 'tbl_seller_products'],
        'tbl_orders': ['tbl_users', 'tbl_addresses'],
        'tbl_seller_products': ['tbl_products', 'tbl_shops', 'tbl_product_categories'],
        'tbl_products': ['tbl_product_categories', 'tbl_brands'],
        'tbl_addresses': ['tbl_users', 'tbl_countries', 'tbl_states'],
        'tbl_user_cart': ['tbl_users', 'tbl_seller_products'],
        'tbl_order_payments': ['tbl_orders'],
        'tbl_coupons': ['tbl_users'],
        'tbl_seller_product_reviews': ['tbl_users', 'tbl_seller_products'],
    }
    
    for table, related_list in explicit_relationships.items():
        if table in tables:
            for related in related_list:
                if related in tables:
                    relationships[table].add((related, None))
    
    return relationships

def get_key_tables_by_category(tables: dict) -> dict:
    """Get key/major tables for each category to include in diagram"""
    key_tables = {
        'User Management': ['tbl_users', 'tbl_admin', 'tbl_addresses', 'tbl_user_auth_token', 'tbl_admin_auth_token'],
        'Product Management': ['tbl_products', 'tbl_product_categories', 'tbl_brands', 'tbl_seller_products', 'tbl_product_to_category'],
        'Order Management': ['tbl_orders', 'tbl_order_products', 'tbl_order_payments', 'tbl_orders_status'],
        'Seller/Vendor Management': ['tbl_shops', 'tbl_seller_packages', 'tbl_commission_settings'],
        'Content Management': ['tbl_blog_post', 'tbl_content_pages', 'tbl_banners', 'tbl_navigations'],
        'Marketing & Promotions': ['tbl_coupons', 'tbl_promotions', 'tbl_badges'],
        'Configuration & Settings': ['tbl_configurations', 'tbl_languages', 'tbl_currency', 'tbl_plugins', 'tbl_countries', 'tbl_states'],
        'Ratings & Reviews': ['tbl_seller_product_reviews', 'tbl_rating_types'],
        'Notifications & Communications': ['tbl_notifications', 'tbl_email_templates', 'tbl_sms_templates'],
        'Reports & Logging': ['tbl_system_logs', 'tbl_cron_log'],
        'Tax Management': ['tbl_tax_categories', 'tbl_tax_rules', 'tbl_tax_structure'],
        'Product Discovery & Search': ['tbl_filters', 'tbl_tags', 'tbl_collections', 'tbl_search_items'],
        'Polling & Questionnaires': ['tbl_polling', 'tbl_questionnaires', 'tbl_questions'],
        'Content & Media Management': ['tbl_attached_files', 'tbl_slides', 'tbl_testimonials'],
        'SEO & URL Management': ['tbl_meta_tags', 'tbl_url_rewrite'],
        'Shopping Cart & User Activity': ['tbl_abandoned_cart', 'tbl_empty_cart_items'],
        'Security & Moderation': ['tbl_abusive_words', 'tbl_failed_login_attempts'],
        'System Utilities': ['tbl_calculative_data', 'tbl_layout_templates', 'tbl_time_slots'],
    }
    
    # Filter to only include tables that actually exist
    filtered = {}
    for category, table_list in key_tables.items():
        filtered[category] = [t for t in table_list if t in tables]
    
    return filtered

def generate_mermaid_diagram(tables: dict, relationships: dict) -> str:
    """Generate mermaid ER diagram with grouped categories"""
    
    key_tables = get_key_tables_by_category(tables)
    
    lines = ["flowchart TD"]
    lines.append("")
    
    # Category order for organization
    category_order = [
        'User Management',
        'Product Management',
        'Order Management',
        'Seller/Vendor Management',
        'Tax Management',
        'Product Discovery & Search',
        'Shopping Cart & User Activity',
        'Content Management',
        'Content & Media Management',
        'Marketing & Promotions',
        'Polling & Questionnaires',
        'Configuration & Settings',
        'SEO & URL Management',
        'Ratings & Reviews',
        'Notifications & Communications',
        'Security & Moderation',
        'Reports & Logging',
        'System Utilities',
    ]
    
    # Create subgraphs for each category
    for category in category_order:
        if category not in key_tables or not key_tables[category]:
            continue
        
        category_id = category.lower().replace(' ', '').replace('&', 'and').replace('/', '').replace('-', '')
        category_label = category
        lines.append(f"    subgraph {category_id}[\"{category_label}\"]")
        
        for table_name in key_tables[category]:
            if table_name not in tables:
                continue
            
            node_id = normalize_table_name(table_name)
            display_name = table_name.replace('tbl_', '').replace('_', ' ')
            lines.append(f"        {node_id}[\"{display_name}\"]")
        
        lines.append("    end")
        lines.append("")
    
    # Add relationships between key tables
    relationships_added = set()
    for category in category_order:
        if category not in key_tables or not key_tables[category]:
            continue
        for table_name in key_tables[category]:
            if table_name not in relationships:
                continue
            
            table_node = normalize_table_name(table_name)
            
            for related_info in relationships[table_name]:
                if isinstance(related_info, tuple):
                    related_table, fk_column = related_info
                else:
                    related_table = related_info
                    fk_column = None
                
                # Only show relationships to other key tables
                related_in_key = False
                for cat, key_list in key_tables.items():
                    if related_table in key_list:
                        related_in_key = True
                        break
                
                if related_in_key:
                    related_node = normalize_table_name(related_table)
                    rel_key = tuple(sorted([table_node, related_node]))
                    if rel_key not in relationships_added and table_node != related_node:
                        relationships_added.add(rel_key)
                        lines.append(f"    {table_node} -->|references| {related_node}")
    
    return "\n".join(lines)

def generate_table_documentation(tables: dict, relationships: dict) -> str:
    """Generate detailed table documentation"""
    docs = []
    
    # Sort tables by category, then alphabetically
    categories = defaultdict(list)
    for table_name, table_info in tables.items():
        categories[table_info['category']].append((table_name, table_info))
    
    category_order = [
        'User Management',
        'Product Management',
        'Order Management',
        'Seller/Vendor Management',
        'Tax Management',
        'Product Discovery & Search',
        'Shopping Cart & User Activity',
        'Content Management',
        'Content & Media Management',
        'Marketing & Promotions',
        'Polling & Questionnaires',
        'Configuration & Settings',
        'SEO & URL Management',
        'Ratings & Reviews',
        'Notifications & Communications',
        'Security & Moderation',
        'Reports & Logging',
        'System Utilities',
        'Other',
    ]
    
    for category in category_order:
        if category not in categories:
            continue
        
        docs.append(f"## {category}")
        docs.append("")
        
        # Sort tables alphabetically within category
        category_tables = sorted(categories[category], key=lambda x: x[0])
        
        for table_name, table_info in category_tables:
            docs.append(f"### `{table_name}`")
            docs.append("")
            
            # Description/Purpose
            table_display = table_name.replace('tbl_', '').replace('_', ' ').title()
            docs.append(f"**Purpose:** Stores {table_display.lower()} information.")
            docs.append("")
            
            # Columns
            docs.append("**Columns:**")
            docs.append("")
            docs.append("| Column Name | Data Type | Primary Key | Not Null | Description |")
            docs.append("|------------|-----------|-------------|----------|-------------|")
            
            for col in table_info['columns']:
                col_name = col['name']
                col_type = col['type']
                is_pk = "✓" if col['is_primary'] else ""
                is_nn = "✓" if col['is_not_null'] else ""
                comment = col['comment'] if col['comment'] else ""
                docs.append(f"| `{col_name}` | `{col_type}` | {is_pk} | {is_nn} | {comment} |")
            
            docs.append("")
            
            # Relationships
            table_relationships = relationships.get(table_name, set())
            if table_relationships:
                docs.append("**Relationships:**")
                docs.append("")
                # Get unique related tables
                related_tables = set()
                for rel_info in table_relationships:
                    if isinstance(rel_info, tuple):
                        related_tables.add(rel_info[0])
                    else:
                        related_tables.add(rel_info)
                
                for rel_table in sorted(related_tables):
                    docs.append(f"- Related to `{rel_table}`")
                docs.append("")
            
            # Foreign Keys
            if table_info['foreign_keys']:
                docs.append("**Foreign Keys:**")
                docs.append("")
                
                # Build comprehensive FK mapping
                fk_to_table_map = {
                    'tbl_lang': 'tbl_languages',
                    'tbl_langs': 'tbl_languages',
                    'tbl_state': 'tbl_states',
                    'tbl_states': 'tbl_states',
                    'tbl_country': 'tbl_countries',
                    'tbl_countries': 'tbl_countries',
                    'tbl_user': 'tbl_users',
                    'tbl_users': 'tbl_users',
                    'tbl_order': 'tbl_orders',
                    'tbl_orders': 'tbl_orders',
                    'tbl_product': 'tbl_products',
                    'tbl_products': 'tbl_products',
                    'tbl_selprod': 'tbl_seller_products',
                    'tbl_seller_products': 'tbl_seller_products',
                    'tbl_shop': 'tbl_shops',
                    'tbl_shops': 'tbl_shops',
                    'tbl_category': 'tbl_product_categories',
                    'tbl_product_categories': 'tbl_product_categories',
                    'tbl_brand': 'tbl_brands',
                    'tbl_brands': 'tbl_brands',
                    'tbl_admin': 'tbl_admin',
                    'tbl_address': 'tbl_addresses',
                    'tbl_addresses': 'tbl_addresses',
                    # Handle parsed variations
                    'tbl_addr_lang': 'tbl_languages',
                    'tbl_addr_langs': 'tbl_languages',
                    'tbl_addr_state': 'tbl_states',
                    'tbl_addr_states': 'tbl_states',
                    'tbl_addr_country': 'tbl_countries',
                    'tbl_addr_countrys': 'tbl_countries',
                    'tbl_addr_record': None,  # Generic record reference
                    'tbl_addr_records': None,
                    'tbl_admauth_admin': 'tbl_admin',
                    'tbl_admauth_admins': 'tbl_admin',
                    'tbl_aprr_admin': 'tbl_admin',
                    'tbl_aprr_admins': 'tbl_admin',
                }
                
                # Use the relationships we built to show actual FK targets
                table_rels = relationships.get(table_name, set())
                relationship_fk_map = {}
                for rel_info in table_rels:
                    if isinstance(rel_info, tuple):
                        target_table, fk_col = rel_info
                        if fk_col:
                            relationship_fk_map[fk_col] = target_table
                
                # Track shown FKs to avoid duplicates
                shown_fks = set()
                
                # First, show relationships we've validated
                for rel_info in table_rels:
                    if isinstance(rel_info, tuple):
                        target_table, fk_col = rel_info
                        if fk_col and fk_col not in shown_fks:
                            shown_fks.add(fk_col)
                            docs.append(f"- `{fk_col}` → `{target_table}`")
                
                # Then check original FK list for any we missed
                for fk_col, fk_target in table_info['foreign_keys']:
                    if fk_col in shown_fks:
                        continue
                    
                    # Try to find actual table
                    actual_target = None
                    if fk_target in tables:
                        actual_target = fk_target
                    elif fk_target in fk_to_table_map:
                        mapped = fk_to_table_map[fk_target]
                        if mapped and mapped in tables:
                            actual_target = mapped
                    
                    if actual_target and actual_target in tables:
                        shown_fks.add(fk_col)
                        docs.append(f"- `{fk_col}` → `{actual_target}`")
                
                docs.append("")
            
            docs.append("---")
            docs.append("")
    
    return "\n".join(docs)

def generate_markdown_documentation(tables: dict) -> str:
    """Generate complete markdown documentation"""
    
    # Build relationships
    relationships = build_relationships(tables)
    
    # Generate mermaid diagram
    mermaid_diagram = generate_mermaid_diagram(tables, relationships)
    
    # Generate table documentation
    table_docs = generate_table_documentation(tables, relationships)
    
    # Count tables by category
    category_counts = defaultdict(int)
    for table_info in tables.values():
        category_counts[table_info['category']] += 1
    
    # Build markdown
    md = []
    md.append("# Database Documentation")
    md.append("")
    md.append("## Overview")
    md.append("")
    md.append(f"This document describes the YoKart e-commerce database schema, containing **{len(tables)} tables** organized into the following functional areas:")
    md.append("")
    
    category_order = [
        'User Management',
        'Product Management',
        'Order Management',
        'Seller/Vendor Management',
        'Tax Management',
        'Product Discovery & Search',
        'Shopping Cart & User Activity',
        'Content Management',
        'Content & Media Management',
        'Marketing & Promotions',
        'Polling & Questionnaires',
        'Configuration & Settings',
        'SEO & URL Management',
        'Ratings & Reviews',
        'Notifications & Communications',
        'Security & Moderation',
        'Reports & Logging',
        'System Utilities',
        'Other',
    ]
    
    for category in category_order:
        if category in category_counts:
            md.append(f"- **{category}**: {category_counts[category]} tables")
    
    md.append("")
    md.append("## Database Schema Diagram")
    md.append("")
    md.append("The following diagram shows the major entity relationships grouped by functional area:")
    md.append("")
    md.append("```mermaid")
    md.append(mermaid_diagram)
    md.append("```")
    md.append("")
    md.append("## Table Reference")
    md.append("")
    md.append("Complete listing of all tables with their structure and relationships:")
    md.append("")
    md.append(table_docs)
    
    return "\n".join(md)

if __name__ == '__main__':
    print("Loading parsed table data...")
    with open('parsed_tables.json', 'r', encoding='utf-8') as f:
        tables = json.load(f)
    
    print(f"Generating documentation for {len(tables)} tables...")
    documentation = generate_markdown_documentation(tables)
    
    output_file = 'DATABASE_DOCUMENTATION.md'
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(documentation)
    
    print(f"Documentation generated: {output_file}")
