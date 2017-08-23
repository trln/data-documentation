Please **do not** directly edit files beginning with "_"

They are generated from other files (here, *argot.xslx*) which need to be kept current. 

If you edit these files, please branch/send merge request so I can make sure relevant master files *argot.xslx* reflect your changes. 

# What's here?

## Files
- **argot.xlsx** - working document - easy for kms to use - has some checks/validatation stuff built in, but can't really be version controlled or opened with anything but Excel without losing data (boo)

- **csvsplit.ps1** - script that splits *argot.xlsx* into csv files

- **_fields.csv** - Argot fields defined. Columns documented in *_fields.md*. Outstanding issues/questions about fields in *_fields_issues.csv*.


- **_mappings.csv** - Mappings from MARC (and eventually other formats) elements/subelements to Argot fields. Columns documented in *_mappings.md*. Outstanding issues/questions about mappings in *_mappings_issues.csv*.

- **processing_rules_and_procedures.md** - instructions for routine processing that applies to all fields, or to categories of fields

- **README.md** - this file.

## Directories

- **helpers** - scripts/etc to pull down data/mappings from other sources for use in data transformations

- **maps** - mappings (json)

- **questions_issues** - explanations/examples of things about which there are questions
