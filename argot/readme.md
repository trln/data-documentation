Please **do not** directly edit .csv files beginning with "_"

They are generated from other files (here, *argot.xslx*) which need to be kept current. 

If you edit these files, please branch/send merge request so I can make sure relevant master files *argot.xslx* reflect your changes. 

# File list
- **argot.xlsx** - working master document 

- **csvsplit.ps1** - script that splits *argot.xlsx* into csv files

- **_fields.csv** - Argot fields defined. Columns documented in *_fields.md*. Outstanding issues/questions about fields in *_fields_issues.csv*.

- **_mappings.csv** - Mappings from MARC (and eventually other formats) elements/subelements to Argot fields. Columns documented in *_mappings.md*. Outstanding issues/questions about mappings in *_mappings_issues.csv*.

- **processing_rules_and_procedures.md** - instructions for routine processing that applies to all fields, or to categories of fields

- **README.md** - this file.

## Why the .xlsx and .csv?
The .xlsx format is easy for Kristina (and probably other data/metadata folks) to use, but has drawbacks. Pros/cons: 
- PRO: has some checks/validatation stuff built in to flag fields/mappings with issues, etc.
- PRO: use tables and formulas to flexibly/easily link up the worksheets for analysis/checking work
- PRO: maintain formatting between work sessions
- CON: can't be meaningfully version controlled via Git without unzipping into hideous Microsoft XML, which is more opaque than anything here (however, I'll keep the binary file tracked here to make sure I'm never the only person who has it)
- CON: can't be opened/worked with any tool but Excel without losing data/messing up formulas

The *csvsplit.ps1* script is used to generate one .csv file per worksheet in *argot.xlsx*. The .csv files are intended to provide: 
- a record of how the data model changed over time (they are plain text, and thus version-controllable)
- quick/easy reference for anyone to check on a field or a mapping without needing the whole .xslx file or access to Excel

# Directory list

- **helpers** - scripts/etc to pull down data/mappings from other sources for use in data transformations

- **maps** - mappings (json)

- **questions_issues** - explanations/examples of things about which there are questions
