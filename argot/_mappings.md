# mappings.csv = rules for converting data from MARC/ICE/EAD/whatever into Argot fields
Columns and values are defined below: 

## Argot field
 - Should match a field specified in https://github.com/trln/data-documentation/blob/master/argot/argot_fields.tsv

## source data format 
 - Source data schema. 
 - Values:
   - MARC
   - MARCish -- not standard MARC, but included in MARC bib data extracts (item, holdings, etc fields mapped into institution-specific, locally-defined MARC fields

## provisional?
 - y : I'm proposing this, but it isn't approved, or putting it in as a placeholder until a question is answered
 - n : proceed with as much confidence as we can muster for anything... :-) 

## institution
 - standard : based on current MARC standard and known legacy MARC data practices. Should apply more or less consistently to any MARC from any institution.
 - DUKE|NCCU|NCSU|UNC : institution-specific mapping

## element/field
- main field tag (MARC) or element (other schema) from which data is mapped

## subelement/field(s)
- subfield(s) (MARC variable fields), byte positions (MARC fixed fields), or element refinement/qualification/subelement (other schema) from which data is to be mapped

## constraints
 - further defines which fields data will be mapped from, based on MARC indicator values, values in subfields in the fields, or values in other parts of the record.

*Conventions used here*
 - i1, i2 = MARC indicators 1, 2 (in the field being examined)
 - $x = MARC subfield (in the field being examined)
 - LDR/06 = the value of byte position 06 of the MARC LDR
 - LDR/06-07 = the concatenated values of byte positions 06 and 07 of the MARC LDR
 - I've tried to follow a clear/simple method of logical expression, with logical operators in all caps and parentheses used to set up sub-logic

## processing_type
 - Basic pattern of processing that is followed. Values explained: 
### concat_subelements 
 - concatenate the contents of any subelements listed
 - keep original order of subelements
 - repeating subelements are fine

The other way of putting this: 
 - take the whole field
 - remove any subelements not included in list
 - remove subfield/subelement delimiters 

Either way: 
 - keep any punctuation provided in between subelements
 - /unless otherwise specified/, add a space at the end of each subelement

Example subelement/field(s) specified: abcde(g)jqu4

Example incoming data: "700 1 2 $aVaughan Williams, Ralph,$d1872-1958,$ecomposer.$tNorfolk rhapsody,$nno. 1.$0http://id.loc.gov/authorities/names/n79139255$0http://viaf.org/viaf/89801735"

Example mapped data: "Vaughan Williams, Ralph, 1872-1958, composer."
### subelement_to_value
 - each instance of listed subelement(s) mapped to separate value (in multivalue field)

Example subelement/field(s) specified: ax

Example incoming data: "650 _ 0 $aMapuche Indians$zPatagonia (Argentina and Chile)$xRites and ceremonies$xHistory."

Example mapped data: ["Mapuche Indians", "Rites and ceremonies", "History"]

## processing instructions
 - special instructions beyond the general processing rules listed below

## notes
 - notes of any type
 - separate individual notes in field with ";;;"

## mapping_id
 - string derived from concatenating other columns
 - will be used to link up these mapping rules with fields, issues, examples and maybe, ambitiously, tests
