#!/usr/bin/env python3
"""
MySQL to PostgreSQL SQL Dump Converter

Converts MySQL dump files to PostgreSQL-compatible SQL.
Handles data types, syntax differences, and MySQL-specific features.
"""

import re
import sys
from typing import List, Tuple

def remove_mysql_conditional_comments(line: str) -> str:
    """Remove MySQL conditional comments like /*!40101 ... */"""
    # Remove MySQL conditional comments
    line = re.sub(r'/\*!\d+\s+SET[^*/]*\*/;?', '', line)
    line = re.sub(r'/\*!\d+\s+.*?\*/', '', line)
    line = re.sub(r'/\*!40000\s+.*?\*/;?', '', line)
    return line.strip()

def convert_backticks(line: str) -> str:
    """Convert MySQL backticks to PostgreSQL double quotes"""
    # Replace backticks with double quotes
    line = re.sub(r'`([^`]+)`', r'"\1"', line)
    return line

def convert_data_types(line: str) -> str:
    """Convert MySQL data types to PostgreSQL equivalents"""
    # Convert tinyint(1) to BOOLEAN
    line = re.sub(r'\btinyint\(1\)\b', 'BOOLEAN', line, flags=re.IGNORECASE)
    # Convert tinyint to SMALLINT (remove size specifiers)
    line = re.sub(r'\btinyint\(\d+\)\b', 'SMALLINT', line, flags=re.IGNORECASE)
    line = re.sub(r'\btinyint\b', 'SMALLINT', line, flags=re.IGNORECASE)
    # Remove size specifiers from integer types (PostgreSQL doesn't support them)
    line = re.sub(r'\b(int|bigint|smallint)\(\d+\)\b', r'\1', line, flags=re.IGNORECASE)
    # Convert datetime to TIMESTAMP
    line = re.sub(r'\bdatetime\b', 'TIMESTAMP', line, flags=re.IGNORECASE)
    # Convert mediumtext to TEXT
    line = re.sub(r'\bmediumtext\b', 'TEXT', line, flags=re.IGNORECASE)
    # Convert longtext to TEXT
    line = re.sub(r'\blongtext\b', 'TEXT', line, flags=re.IGNORECASE)
    # Remove unsigned from integer types
    line = re.sub(r'\b(int|bigint|smallint)\s+unsigned\b', r'\1', line, flags=re.IGNORECASE)
    # Remove CHARACTER SET and COLLATE from column definitions
    line = re.sub(r'\s+CHARACTER\s+SET\s+\w+\s+COLLATE\s+\w+', '', line, flags=re.IGNORECASE)
    return line

def remove_table_options(line: str) -> str:
    """Remove MySQL-specific table options"""
    # Remove ENGINE=InnoDB
    line = re.sub(r'\s+ENGINE\s*=\s*InnoDB', '', line, flags=re.IGNORECASE)
    # Remove AUTO_INCREMENT=n
    line = re.sub(r'\s+AUTO_INCREMENT\s*=\s*\d+', '', line, flags=re.IGNORECASE)
    # Remove DEFAULT CHARSET and COLLATE
    line = re.sub(r'\s+DEFAULT\s+CHARSET\s*=\s*\w+', '', line, flags=re.IGNORECASE)
    line = re.sub(r'\s+COLLATE\s*=\s*\w+', '', line, flags=re.IGNORECASE)
    # Remove USING BTREE from indexes
    line = re.sub(r'\s+USING\s+BTREE', '', line, flags=re.IGNORECASE)
    # Remove COMMENT='...' at table level
    line = re.sub(r"\s+COMMENT\s*=\s*'[^']*'", '', line, flags=re.IGNORECASE)
    return line

def convert_auto_increment_in_column(line: str) -> str:
    """
    Convert AUTO_INCREMENT column definition to SERIAL.
    Pattern: "column_name" int NOT NULL AUTO_INCREMENT -> "column_name" SERIAL NOT NULL
    """
    # Pattern to match with quotes: "column_name" type NOT NULL AUTO_INCREMENT
    # Also handle unquoted column names
    patterns = [
        # Quoted column names
        (r'"(\w+)"\s+(int|INT)\s+(NOT\s+NULL\s+)?AUTO_INCREMENT', r'"\1" SERIAL \3'),
        (r'"(\w+)"\s+(bigint|BIGINT)\s+(NOT\s+NULL\s+)?AUTO_INCREMENT', r'"\1" BIGSERIAL \3'),
        (r'"(\w+)"\s+(smallint|SMALLINT)\s+(NOT\s+NULL\s+)?AUTO_INCREMENT', r'"\1" SMALLSERIAL \3'),
        # Unquoted column names (fallback)
        (r'(\w+)\s+(int|INT)\s+(NOT\s+NULL\s+)?AUTO_INCREMENT', r'\1 SERIAL \3'),
        (r'(\w+)\s+(bigint|BIGINT)\s+(NOT\s+NULL\s+)?AUTO_INCREMENT', r'\1 BIGSERIAL \3'),
        (r'(\w+)\s+(smallint|SMALLINT)\s+(NOT\s+NULL\s+)?AUTO_INCREMENT', r'\1 SMALLSERIAL \3'),
    ]
    
    for pattern, replacement in patterns:
        new_line = re.sub(pattern, replacement.strip(), line, flags=re.IGNORECASE)
        if new_line != line:
            line = new_line
            break  # Only apply one pattern
    
    return line

def convert_invalid_dates(line: str) -> str:
    """Convert MySQL invalid dates '0000-00-00 00:00:00' to NULL"""
    # Replace invalid dates with NULL
    line = re.sub(r"'0000-00-00 00:00:00'", 'NULL', line)
    line = re.sub(r"'0000-00-00'", 'NULL', line)
    return line

def convert_on_update_current_timestamp(line: str) -> str:
    """Remove ON UPDATE CURRENT_TIMESTAMP (PostgreSQL uses triggers for this)"""
    line = re.sub(r'\s+ON\s+UPDATE\s+CURRENT_TIMESTAMP', '', line, flags=re.IGNORECASE)
    return line

def process_create_table_block(block: str, table_name: str) -> Tuple[str, List[str]]:
    """
    Process a complete CREATE TABLE block.
    Returns (processed_block, list_of_index_statements)
    """
    index_statements = []
    
    # Apply backtick conversion first
    block = convert_backticks(block)
    
    # Extract KEY definitions (not PRIMARY KEY or UNIQUE KEY)
    # Use a function to check the context before matching
    def extract_key_with_context(match_obj):
        # Check the text before the match to see if it's UNIQUE KEY or PRIMARY KEY
        match_start = match_obj.start()
        # Look further back to catch "UNIQUE KEY" or "PRIMARY KEY"
        text_before = block[max(0, match_start-30):match_start].upper()
        # Check if UNIQUE or PRIMARY appears before KEY (with optional whitespace)
        if 'UNIQUE' in text_before[-15:] or 'PRIMARY' in text_before[-15:]:
            return match_obj.group(0)  # Return the original match unchanged
        
        key_name = match_obj.group(1)
        columns = match_obj.group(2).strip()
        cols = [c.strip().strip('"').strip('`') for c in columns.split(',')]
        quoted_cols = ', '.join(f'"{col}"' for col in cols)
        index_stmt = f'CREATE INDEX IF NOT EXISTS "{key_name}" ON "{table_name}" ({quoted_cols});\n'
        index_statements.append(index_stmt)
        return ''  # Remove the KEY definition
    
    # Pattern to match KEY (but we'll check context in the function)
    key_pattern = r',?\s+KEY\s+"?(\w+)"?\s*\(([^)]+)\)'
    
    # Remove KEY definitions (but keep UNIQUE KEY and PRIMARY KEY)
    block = re.sub(key_pattern, extract_key_with_context, block, flags=re.IGNORECASE)
    
    # Clean up any double commas or trailing commas before )
    block = re.sub(r',\s*,', ',', block)
    block = re.sub(r',\s*\)', ')', block)
    # Clean up leading comma after removed KEY
    block = re.sub(r'\(\s*,', '(', block)
    
    # Apply data type conversions
    block = convert_data_types(block)
    
    # Remove size specifiers from integer types that might remain (e.g., SMALLINT(1))
    # Handle both quoted and unquoted column names
    block = re.sub(r'\b(SMALLINT|INT|BIGINT)\(\d+\)', r'\1', block, flags=re.IGNORECASE)
    
    # Convert AUTO_INCREMENT columns
    lines = block.split('\n')
    converted_lines = []
    for line in lines:
        line = convert_auto_increment_in_column(line)
        line = convert_on_update_current_timestamp(line)
        converted_lines.append(line)
    block = '\n'.join(converted_lines)
    
    # Remove table options
    block = remove_table_options(block)
    
    # Clean up trailing commas before closing parenthesis
    block = re.sub(r',\s*\)\s*;', ');', block)
    
    return block, index_statements

def convert_on_duplicate_key(line: str, table_name: str = None) -> str:
    """Convert ON DUPLICATE KEY UPDATE to ON CONFLICT DO UPDATE"""
    if 'ON DUPLICATE KEY UPDATE' not in line.upper():
        return line
    
    # Extract the table name if we can find it
    # For ON CONFLICT, we need to specify the conflict target (usually PRIMARY KEY)
    # This is a simplified conversion - may need manual adjustment
    update_match = re.search(r'ON DUPLICATE KEY UPDATE\s+(.+)', line, re.IGNORECASE | re.DOTALL)
    if update_match:
        update_clause = update_match.group(1).strip().rstrip(';')
        # Replace VALUES(column) with EXCLUDED.column
        update_clause = re.sub(r'VALUES\s*\((\w+)\)', r'EXCLUDED.\1', update_clause, flags=re.IGNORECASE)
        # Convert column = VALUES(column) to column = EXCLUDED.column
        update_clause = re.sub(r'(\w+)\s*=\s*VALUES\s*\((\w+)\)', r'\1 = EXCLUDED.\2', update_clause, flags=re.IGNORECASE)
        
        # Replace the ON DUPLICATE KEY UPDATE part
        line = re.sub(
            r'ON DUPLICATE KEY UPDATE\s+.+',
            f'ON CONFLICT DO UPDATE SET {update_clause}',
            line,
            flags=re.IGNORECASE | re.DOTALL
        )
    
    return line

def convert_mysql_dump_to_postgres(input_file: str, output_file: str):
    """Main conversion function"""
    
    with open(input_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Split into lines for processing
    lines = content.split('\n')
    
    output_lines = []
    pending_indexes = []
    table_count = 0
    
    i = 0
    while i < len(lines):
        line = lines[i]
        original_line = line
        
        # Skip MySQL header comments (first 20 lines)
        if i < 20:
            if any(x in line for x in ['MySQL dump', 'Server version', 'Host:', 'Database:']):
                i += 1
                continue
        
        # Skip MySQL SET statements at the beginning (conditional comments)
        if re.search(r'/\*!40\d+\s+SET', line):
            i += 1
            continue
        
        # Skip MySQL SET statements at the end
        if re.search(r'/\*!40\d+\s+SET\s+(TIME_ZONE|SQL_MODE|FOREIGN_KEY_CHECKS|UNIQUE_CHECKS|CHARACTER_SET|SQL_NOTES)', line):
            i += 1
            continue
        
        # Handle dump completed comment
        if 'Dump completed on' in line:
            output_lines.append(f'-- PostgreSQL dump converted from MySQL\n')
            output_lines.append(f'-- {line.lstrip("- ")}')
            i += 1
            continue
        
        # Remove conditional comments from the line
        cleaned_line = remove_mysql_conditional_comments(line)
        if not cleaned_line and not line.strip():
            i += 1
            continue
        
        # Skip LOCK TABLES
        if re.match(r'LOCK\s+TABLES', cleaned_line, re.IGNORECASE):
            i += 1
            continue
        
        # Skip UNLOCK TABLES
        if re.match(r'UNLOCK\s+TABLES', cleaned_line, re.IGNORECASE):
            i += 1
            continue
        
        # Skip ALTER TABLE ... DISABLE/ENABLE KEYS
        if 'DISABLE KEYS' in cleaned_line.upper() or 'ENABLE KEYS' in cleaned_line.upper():
            i += 1
            continue
        
        # Skip SET character_set_client lines
        if 'SET @saved_cs_client' in cleaned_line or ('character_set_client' in cleaned_line and 'SET' in cleaned_line):
            i += 1
            continue
        
        # Handle CREATE TABLE - need to capture multi-line blocks
        if 'CREATE TABLE' in cleaned_line.upper() and not cleaned_line.upper().startswith('--'):
            # Extract table name
            table_match = re.search(r'CREATE\s+TABLE\s+(?:IF\s+NOT\s+EXISTS\s+)?`?(\w+)`?', cleaned_line, re.IGNORECASE)
            table_name = table_match.group(1) if table_match else None
            
            # Collect the entire CREATE TABLE block
            create_block = [cleaned_line]
            paren_count = cleaned_line.count('(') - cleaned_line.count(')')
            j = i + 1
            
            while j < len(lines) and paren_count > 0:
                next_line = lines[j]
                # Remove conditional comments but keep the line structure
                next_cleaned = remove_mysql_conditional_comments(next_line)
                if next_cleaned or next_line.strip():
                    create_block.append(next_cleaned if next_cleaned else next_line.rstrip())
                paren_count += next_line.count('(') - next_line.count(')')
                j += 1
            
            # Process the CREATE TABLE block
            full_block = '\n'.join(create_block)
            processed_block, indexes = process_create_table_block(full_block, table_name)
            
            # Ensure proper formatting - add newline after CREATE TABLE
            if not processed_block.endswith('\n'):
                processed_block += '\n'
            
            output_lines.append(processed_block)
            
            pending_indexes.extend(indexes)
            table_count += 1
            
            i = j
            continue
        
        # Handle INSERT statements
        if cleaned_line.upper().startswith('INSERT INTO'):
            processed_line = convert_backticks(cleaned_line)
            processed_line = convert_invalid_dates(processed_line)
            # Remove leading semicolons
            processed_line = re.sub(r'^;+', '', processed_line)
            output_lines.append(processed_line)
            i += 1
            continue
        
        # Handle DROP TABLE
        if cleaned_line.upper().startswith('DROP TABLE'):
            processed_line = convert_backticks(cleaned_line)
            # Ensure proper separation from CREATE TABLE
            if processed_line and not processed_line.endswith('\n'):
                processed_line += '\n'
            output_lines.append(processed_line)
            i += 1
            continue
        
        # Handle UPDATE statements (may span multiple lines)
        if cleaned_line.upper().startswith('UPDATE '):
            update_block = [cleaned_line]
            j = i + 1
            # Collect until semicolon
            while j < len(lines) and not cleaned_line.rstrip().endswith(';'):
                next_line = lines[j]
                next_cleaned = remove_mysql_conditional_comments(next_line)
                if next_cleaned:
                    update_block.append(next_cleaned)
                    cleaned_line = next_cleaned
                j += 1
                if cleaned_line.rstrip().endswith(';'):
                    break
            
            update_stmt = '\n'.join(update_block)
            update_stmt = convert_backticks(update_stmt)
            output_lines.append(update_stmt)
            i = j
            continue
        
        # Handle INSERT with ON DUPLICATE KEY UPDATE (may span multiple lines)
        if 'ON DUPLICATE KEY UPDATE' in cleaned_line.upper():
            # Collect the full statement
            dup_block = [cleaned_line]
            j = i + 1
            while j < len(lines) and not cleaned_line.rstrip().endswith(';'):
                next_line = lines[j]
                next_cleaned = remove_mysql_conditional_comments(next_line)
                if next_cleaned:
                    dup_block.append(next_cleaned)
                    cleaned_line = next_cleaned
                j += 1
                if cleaned_line.rstrip().endswith(';'):
                    break
            
            dup_stmt = '\n'.join(dup_block)
            # Extract table name from INSERT INTO
            table_match = re.search(r'INSERT\s+INTO\s+`?(\w+)`?', dup_stmt, re.IGNORECASE)
            table_name = table_match.group(1) if table_match else None
            
            dup_stmt = convert_backticks(dup_stmt)
            dup_stmt = convert_invalid_dates(dup_stmt)
            dup_stmt = convert_on_duplicate_key(dup_stmt, table_name)
            output_lines.append(dup_stmt)
            i = j
            continue
        
        # Apply general conversions to other lines
        processed_line = convert_backticks(cleaned_line)
        processed_line = convert_data_types(processed_line)
        processed_line = convert_invalid_dates(processed_line)
        
        if processed_line.strip():
            output_lines.append(processed_line)
        
        i += 1
    
    # Write output file
    with open(output_file, 'w', encoding='utf-8') as f:
        # Write PostgreSQL header
        f.write("-- PostgreSQL dump converted from MySQL\n")
        f.write("-- Original file: sample.sql\n\n")
        f.write("SET client_encoding = 'UTF8';\n\n")
        
        # Write all converted SQL
        for line in output_lines:
            f.write(line)
            if line and not line.endswith('\n') and not line.endswith(';'):
                f.write('\n')
        
        # Add CREATE INDEX statements at the end
        if pending_indexes:
            f.write("\n-- Additional indexes converted from MySQL KEY definitions\n\n")
            for idx in pending_indexes:
                f.write(idx)
    
    print(f"Conversion complete!")
    print(f"Input:  {input_file}")
    print(f"Output: {output_file}")
    print(f"Tables processed: {table_count}")
    print(f"Indexes to create: {len(pending_indexes)}")
    print(f"\nNote: Review the output file for any remaining MySQL-specific syntax.")
    print(f"Some features like ON UPDATE CURRENT_TIMESTAMP may need PostgreSQL triggers.")

if __name__ == '__main__':
    input_file = 'sample.sql'
    output_file = 'sample_postgres.sql'
    
    if len(sys.argv) > 1:
        input_file = sys.argv[1]
    if len(sys.argv) > 2:
        output_file = sys.argv[2]
    
    convert_mysql_dump_to_postgres(input_file, output_file)
