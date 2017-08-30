# Handling MARC subfields $3 and $i
## Summary
Please advise on modeling this across-MARC pattern in Argot: 

- When they occur, $3 and $i should display as labels on fields
  - Most fields where $3 and $i are defined are repeatable and should be shown in the same order as they occur in the catalog record.
- When present, $3 and $i should **not** be indexed as part of the content of the field. Reasons why I'm saying the $3 and/or $i should not be indexed include: 
  - The values here are provided by catalogers and would not be known to users before searching, so indexing does not add useful findability
  - When $3 or $i is included in some types of fields (notes, for instance) it doesn't cause much of a problem or matter much -- we can just include them in the main indexed field(s) in this case
  - However, these subfields are heavily used in fields that record author and title information.
    - I have assumed the indexed versions of the data in such fields could in some cases feed into auto-suggest, in which case we do NOT want labels/contextual info not part of the names/titles to be included
    - Because these are often controlled values (and in Endeca, we have hyperlinked some of these names/titles to query for other records with the same headings), concerns about a) spuriously small search results if $3 and $i values are included in the hyperlink-query; and b) effects on relevance ranking (if whole field match plays or left-anchored match plays in) if the $3 and $i labels are included in indexed values
	- EXAMPLE: Broken query because $i is included in indexed value/query built into UI: [Author/title search for Shakespeare's Othello](http://search.lib.unc.edu/search?N=0&Ntk=Author|Title&Ntt=%22Shakespeare%2C+William%2C+1564-1616.%22|%22Opera+adaptation+of+%28work%29%3A+Othello.+Italian.%22&follow=Author|Title_Details) returns one hit -- it *should* work [this way](http://search.lib.unc.edu/search?N=0&Ntk=Author|Title&Ntt=%22Shakespeare%2C+William%2C+1564-1616.%22|%22Othello%22&follow=Author|Title_Details)
- Neither $3 nor $i is required in any field -- they are used when necessary (see below for details)
 - $3 available for use in 77 MARC fields
 - $i avaliable for use in 29 MARC fields
- These subfields are currently rather sparse in the data. They are relatively new subfields, but are expected to be used more heavily as MARC evolves



## Details on $3
- ABOUT
  - Defined across the MARC standard as "Material specified"
  - **Defined for use in 77 MARC tags** and seems to be added to more fields with every MARC update
  - Used when the data recorded in the field applies to/describes only part of the overall resource described by the record
  - The part(s) to which the field applies are specified in $3
  - There is no clear standard policy or practice for $3's location in a MARC field -- some catalogers prefer to put it first; some put it at the end of the field
- DISPLAY
  - $3 is necessary for an accurate/meaningful display, so that we are not implying the data in the field describes/applies to the entire thing described by the record
  - For display, it should appear first, as a qualifying label to the rest of the field.
  - Most fields where $3 is defined are repeatable and should be shown in the same order as they occur in the catalog record.
- INDEXING
  - $3 should NOT be included in any indexes (except for keyword index, and only then if we decide to dump the entire record in that index)

### $3 examples

In UNC's catalog, $3 is most heavily used in the 856 field. 856 coding practices remain highly unstandardized across institutions, so I'll give other examples below

For continuing resources where publisher has changed over time, $3 specifies the dates each publisher was active:

```
260 3 _ $3<2013->:$aPeterborough, Ontario :$bBaywolf Press
```

This could be displayed as: 

> **Publication details**
>> (2013-): Peterborough, Ontario : Baywolf Press

Here, the way a series title appeared in the volumes of that series changed over time. $3 is used to specify, for example, that between 1979 and 2004, the series title on the item was "Resource bulletin NC":
```
490 1 _ $31965-1978:$aUSDA Forest Service resource bulletin NC
490 1 _ $31979-2004:$aResource bulletin NC
490 1 _ $32005:$aResource bulletin NRS
```

This could be displayed as: 

> **Included in series:** 
>> (1965-1978): USDA Forest Service resource bulletin NC

>> (1979-2004): Resource bulletin NC

>> (2005): Resource bulletin NRS

Here, the bib describes the whole box set. The $3 is used to qualify the transcribed series titles/volume info for the set as a whole, and each piece in the set.
```
490 1 _ $3Box set:$aCriterion Collection ;$v813
490 1 _ $3Alice in the Cities:$aCriterion collection ;$v814
490 1 _ $3Wrong Move:$aCriterion collection ;$v815
490 1 _ $3Kings of the Road:$aCriterion collection ;$v816
```

Possible display:

> **Included in series:** 
>> (Box set): Criterion Collection ; 813

>> (Alice in the Cities): Criterion collection ; 814

>> (Wrong Move): Criterion collection ; 815

>> (Kings of the Road): Criterion collection ; 816

## Details on $i
  - **ABOUT**
    - $i is **defined for use in 39 MARC tags** and seems to be added to more fields with every MARC update
    - When defined, $i is usually, but not always, called something like: "Display text" or "Relationship information". **HOWEVER**, in some fields, it's something else altogether
    - Because of the inconsistency mentioned in the previous point, there's no simple blanket definition of $i, but **in general** (and for our purposes) it is used in fields that record data about some entity related to the one described by the record. 
    - The $i specifies how that other entity is related to the one being described here. 
    - There is no clear standard policy or practice mandated for $i's location in a MARC field -- however, it is usually put first
  - **DISPLAY**
    - $i (or a modified version of it) is necessary for an accurate/meaningful display.
    - For display, it should appear first, as a qualifying label to the rest of the field.
    - Most fields where $3 is defined are repeatable and should be shown in the same order as they occur in the catalog record.
  - **INDEXING**
    - $i should NOT be included in any indexes (except for keyword index, and only then if we decide to dump the entire record in that index)
    - $i can be leveraged to determine how certain fields should be indexed

### $i examples

The FRBR WEMI terms in parentheses should be stripped out for display, but we could use this to index Shakespeare's Othello as a related work (or Shakespeare as a related author). The work described in this record may be interesting to a user searching for Shakespeare's Othello, but it probably isn't highly relevant. 

Likewise, we use the 787$i to index that work as a "version of" this one---exact titles and details may differ between reproductions but if a user's searching for the original thing, the work described here is much more likely to be relevant. 
```
100 	1#$aVerdi, Giuseppe, $d1813-1901.
245 	10$aOthello :$bin full score /$cGiuseppe Verdi.
700 	1#$iLibretto based on (work):$aShakespeare, William,$d1564-1616.$tOtello.
787 	08$iReproduction of (manifestation):$aVerdi, Giuseppe, 1813-1901.$tOtello.$dMilano: Ricordi, c1913
```

Possible display: 

> **Author**
>> Verdi, Giuseppe, 1813-1901.

> **Title**
>> Othello : in full score / Giuseppe Verdi.

> **Other formats/versions**
>> Reproduction of: Verdi, Giuseppe, 1813-1901. Otello. Milano: Ricordi, c1913

> **Related works**
>> Libretto based on: Shakespeare, William, 1564-1616. Otello.


## subfield $3 AND $i
 - This happens. Of course it does.
 - It's possible in 10 MARC fields, 5 of which we will definitely need to handle for indexing/display

In these cases: 
 - neither $3 nor $i should be indexed (except for keyword index, if we decide we're dumping the whole record in there)
 - $3 should be displayed before $i, regardless of the order of these fields in the record

From a record describing a recording of multiple works, one of which was based on another work cited in this 700 field: 
```
700 1 _ $31st work$iBased on (work):$aKrell, Max,$d1887-1962.$tDämon.
```

Could display as: 

> **Related works**
>> (1st work): Based on: Krell, Max, 1887-1962. Dämon.

From a record describing a book containing multiple works, one of which (Liber gestorum) is an adaptation of the related work cited in the 700:
```
700 0 _ $3Liber gestorum$iAdaptation of:$aJames$bI,$cKing of Aragon,$d1208-1276.$tLlibre dels fets.
```

> **Related works**
>> (Liber gestorum): Adaptation of: James I, King of Aragon, 1208-1276. Llibre dels fets.
