#!/usr/bin/env python
import sys
def supported(from_int, from_modifier, to_int, to_modifer):
    if from_modifier != to_modifer:
        return False
    if from_int > to_int:
        return False
    return True
def gen_tests_for_int(from_int, from_modifier, int_types, modifiers):
    for to_int in range(len(int_types)):
        for to_modifer in range(len(modifiers)):
            print
            print "CREATE TABLE t (a %s %s);" % (int_types[from_int], modifiers[from_modifier])
            if not supported(from_int, from_modifier, to_int, to_modifer):
                print "--replace_regex /MariaDB/XYZ/ /MySQL/XYZ/"
                print "--error ER_UNSUPPORTED_EXTENSION"
            print "ALTER TABLE t CHANGE COLUMN a a %s %s;" % (int_types[to_int], modifiers[to_modifer])
            print "DROP TABLE t;"
def gen_tests(int_types, modifiers):
    for from_int in range(len(int_types)):
        for from_modifier in range(len(modifiers)):
            gen_tests_for_int(from_int, from_modifier, int_types, modifiers)
def main():
    print "# this test is generated by change_int_not_supported.py"
    print "# ensure that int types are only expanded and are not cnverted to some other type"
    print "--disable_warnings"
    print "DROP TABLE IF EXISTS t;"
    print "--enable_warnings"
    print "SET SESSION DEFAULT_STORAGE_ENGINE=\"TokuDB\";"
    print "SET SESSION TOKUDB_DISABLE_SLOW_ALTER=1;"
    gen_tests(
        [ "TINYINT", "SMALLINT", "MEDIUMINT", "INT", "BIGINT" ], 
        [ "", "NOT NULL", "UNSIGNED", "UNSIGNED NOT NULL" ]
    )
    return 0
sys.exit(main())
