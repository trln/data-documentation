

# About the files here

This is currently a mess because it's early in the process. Stuff will be restructured/clarified later&#x2026;

-   .tsv and .txt files: data documentation/mapping files
    -   **IMPORTANT WARNING!**: data files beginning with \_ are generated based on other data files. Do not edit them directly, or you will lose your edits.
-   .rb files: ruby scripts that:
    -   extract data documentation/mapping files from code, config files, or other data sources
    -   manipulate data documentation/mapping files &#x2013; combining, summarizing, etc.
-   .org files - notes, textual documentation, tasks, etc.
    -   [endeca\_data\_preparation.org](https://github.com/trln/data-documentation/blob/master/endeca_data_preparation.org) - Details on preparation of Endeca-specific data documentation and what lives in the files
    -   [update\_2017-01-23.org](https://github.com/trln/data-documentation/blob/master/update_2017-01-23.org) - notes for Steering Committee meeting
    -   [work.org](https://github.com/trln/data-documentation/blob/master/work.org) - task planning/tracking
    -   [working\_notes.org](https://github.com/trln/data-documentation/blob/master/working_notes.org) - notes not otherwise organized &#x2013; best to ignore
    -   [README.org](https://github.com/trln/data-documentation/blob/master/README.org) - generates README.md


# Vision for a maintainable, usable suite of data documentation that meets ongoing project needs


## further feature development

-   clear
-   complete
-   correct


## issue resolution

-   collaborative
-   version controlled


## maintenance

-   easy to update, current
    -   automate whatever can be automated (i.e. leverage extraction of human-readable documentation from code, config files)
    -   follow standards for open online data formatting and sharing
-   supports periodic review of data needs as original data source standards evolve


## empowering library staff (and by extension, library users) to better understand how their catalog works

-   accessible
-   provides simple ways to arrive at answers to the common types of data questions that arise such as: 
    -   Public services staff: What does Publisher search actually search (MARC fields/subfields from the catalog record, metadata elements from digital collection record, etc)?
    -   Tech services/IT/metadata staff: If I record this data in a given MARC tag/subfield, or output it from a repository to given DC/MODS field, will it be searchable and/or displayed in the public catalog?
    -   Staff, superusers: I see this data in the ILS client/classic view/WorldCat/MARC-or-'librarian view', but I don't see it in the public catalog record. Why?
    -   Everyone: Why did this record come up in my search? or Why didn't this record come up in my search?
    -   Everyone: Why are my search results in this order?


## shift bulk of succession planning/new employee training responsibility to Data Team, rather than staff at individual institutions


# Resources and notes

-   [Concept and workflow of **data lineage** for documenting ETL](http://docwiki.embarcadero.com/ERStudioDA/XE7/en/Documenting_Data_Extraction,_Transformation,_and_Load)

