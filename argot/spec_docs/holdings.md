# Argot *holdings* field

The Argot *holdings* field is an array of holdings elements. Each holdings element is an an escaped JSON string representing:
* a holdings record attached to the bib, OR
* holdings information for a particular location derived from another source

* **Required?**
  * Optional, but should be consistent per format per institution.
	* If no *holdings* data exists in the Argot record, Argon can derive a placeholder "holdings" based on item data. Out of the box this isn't great, but could be developed further. See [Holdings data in Argot and Argon](https://trlnmain.atlassian.net/wiki/spaces/TD/pages/6422529/Holdings+data+in+Argot+and+Argon) for more on this.
  * Not used in display of online resources
* **Repeatable/multivalued?**
  * The *holdings* field itself is not repeated in the Argot record representing a bib record
  * The *holdings* field may contain multiple elements representing multiple holdings records or statements
  * The order of holdings elements in the *holdings* field should represent the display order of holdings records desired

## Subelements
* **call_no**
  * Call number on holdings record
  * Required if applicable
* **loc_b** - Broad location - Library building, major area/division
  * ILS code
  * Required
* **loc_n** - Narrow location
  * ILS code
  * Required
* **notes** - Holdings notes for public display
  * Array, where each separate note from holdings record is an element
  * Required if display of public notes is desired
  * Preferred: do not send a *notes* key with empty array as value if there are no notes to publicly display
* **holdings_id**
  * Local, unique id of holdings record
  * Optional per institution - format consistently to meet institutional needs
* **summary** - Summary holdings statement -- representation of what items are included at the location specified
  * Array, where each separate holdings summary (main bib unit, supplement, index) is an element
  * Required if applicable
  * Preference: do not send a *summary* key with empty array as value if there are no summaries for a holdings record.

## Basic structure of *holdings* field in Argot

Examples are shown here with line breaks and indentation to make it easier to visually parse them. In real Argot, each *holdings* element is just a string that looks like: 
``` JSON
holdings = ["{\"loc_b\" : \"DHHILL\", \"loc_n\" : \"STACKS\", \"summary\" : \"Issues from 2015-2016\", \"call_no\" : \"ABC 123\"}","{\"loc_b\" : \"DHHILL\", \"loc_n\" : \"OTHERPLACE\", \"summary\" : \"Current issues\", \"call_no\" : \"ABC 123\"}"]
```

``` JSON
holdings = [
  "{
  \"loc_b\" : \"wbdb\",
  \"loc_n\" : \"wbdb\",
  \"call_no\" : \"FC362.3 C35p\",
  \"notes\" : [
    \"Missing v.9,no.8; v.10,no.7-8; v.13,no.5.\"
	],
  \"summary\" : [
    \"vol. 1, no.1 (January 1979)- vol. 23, no. 5 (June 2003)\"
	]
  }",
  "{
  \"loc_b\" : \"bbha\",
  \"loc_n\" : \"bbha\",
  \"notes\" : [
    \"Latest in Science Library Annex Serials\"
	],
  \"holdings_id\" : \"c2792043\"
  }"
]
```

``` JSON
holdings = [
  "{
    \"loc_b\" : \"DHHILL\", 
	\"loc_n\" : \"STACKS\", 
	\"summary\" : \"Issues from 2015-2016\", 
	\"call_no\" : \"ABC 123\"
   }",
  "{
    \"loc_b\" : \"DHHILL\", 
	\"loc_n\" : \"OTHERPLACE\", 
	\"summary\" : \"Current issues\", 
	\"call_no\" : \"ABC 123\"
   }"
]
```

## Institution-specific item mapping examples
Institutions are encouraged, but not required to document their item mappings here.

### UNC mapping examples


Basic procedure: 
- Get the following values from each 999 92:
  - rec\_id ($a)
  - loc\_b ($b)
  - loc\_n ($b)
  - $c (holdings card count, used to determine whether to send rec\_id through in Argot)
- For each holdings rec\_id value: 
  - call_no = 999|93|hijk where $0==#{rec\_id} and $2=='852' and $3=='c'
  - notes = Assign each as element of notes array. Uniquify.
    - 999|93|z where $0==#{rec\_id} and $2=~/86[3-8]/
    - 999|93|lz where $0==#{rec\_id} and $2='852' and $3=='c'
  - summary = array from 999|93|a where $0==#{rec\_id} and...
    - $2=='866' 
	- $2=='867' -- "Supplementary material: #{$a value}"
	- $2=='868' -- "Indexes: #{$a value}"
  - rec\_id -- send through to final Argot record if holdings card count > 0 (see above)

We'll have to determine how many unsuppressed holdings records lack textual holdings statements (866-868) and weigh whether
- it should be a data cleanup project for SerCat to add them, OR
- we try to mush them together in MARC-to-Argot based on 853-855 + 863-865

### Two holdings records -- summary holdings provided in record
``` xml
      <datafield ind1='9' ind2='2' tag='999'>
        <subfield code='a'>c4862596</subfield>
        <subfield code='b'>bbdaa</subfield>
        <subfield code='c'>0</subfield>
      </datafield>
      <datafield ind1='9' ind2='3' tag='999'>
        <subfield code='0'>c4862596</subfield>
        <subfield code='2'>852</subfield>
        <subfield code='3'>c</subfield>
        <subfield code='b'>577711</subfield>
        <subfield code='h'>ML113</subfield>
        <subfield code='i'>.I6 B IX</subfield>
		<subfield code='l'>Shelved on Index Table</subfield>
      </datafield>
      <datafield ind1='9' ind2='3' tag='999'>
        <subfield code='0'>c4862596</subfield>
        <subfield code='2'>853</subfield>
        <subfield code='3'>y</subfield>
        <subfield code='8'>1</subfield>
        <subfield code='a'>v.</subfield>
        <subfield code='b'>no.</subfield>
        <subfield code='i'>(year)</subfield>
      </datafield>
      <datafield ind1='9' ind2='3' tag='999'>
        <subfield code='0'>c4862596</subfield>
        <subfield code='2'>866</subfield>
        <subfield code='3'>h</subfield>
        <subfield code='8'>1</subfield>
        <subfield code='a'>v.1(1988)-v.25(2012)</subfield>
      </datafield>
      <datafield ind1='9' ind2='2' tag='999'>
        <subfield code='a'>c2786750</subfield>
        <subfield code='b'>dgdba</subfield>
        <subfield code='c'>1</subfield>
      </datafield>
      <datafield ind1='9' ind2='3' tag='999'>
        <subfield code='0'>c4862596</subfield>
        <subfield code='2'>852</subfield>
        <subfield code='3'>c</subfield>
        <subfield code='b'>572261</subfield>
        <subfield code='h'>TX715</subfield>
        <subfield code='i'>.P962 1858</subfield>
		<subfield code='z'>Bound in brown rib grain (T) cloth binding stamped in blind.</subfield>
		<subfield code='z'>Recipes clipped from newspapers pasted on both sides of rear free end-paper.</subfield>
      </datafield>
      <datafield ind1='9' ind2='3' tag='999'>
        <subfield code='0'>c2786750</subfield>
        <subfield code='2'>853</subfield>
        <subfield code='3'>y</subfield>
        <subfield code='8'>1</subfield>
        <subfield code='a'>v.</subfield>
        <subfield code='b'>no.</subfield>
        <subfield code='i'>(year)</subfield>
      </datafield>
      <datafield ind1='9' ind2='3' tag='999'>
        <subfield code='0'>c2786750</subfield>
        <subfield code='2'>866</subfield>
        <subfield code='3'>h</subfield>
        <subfield code='8'>1</subfield>
        <subfield code='a'>v.26(2013/2014)</subfield>
      </datafield>
```

**Result:**

``` json
holdings = [
  "{
  \"loc_b\" : \"bbdaa\", 
  \"loc_n\" : \"bbdaa\", 
  \"summary\" : \"v.1(1988)-v.25(2012)\", 
  \"notes\" : [
    \"Shelved on Index Table\"
	], 
  \"call_no\" : \"ML113 .I6 B IX\"
  },
  {
  \"loc_b\" : \"dgdba\", 
  \"loc_n\" : \"dgdba\", 
  \"summary\" : \"v.26(2013/2014)\", 
  \"notes\" : [
    \"Bound in brown rib grain (T) cloth binding stamped in blind.\", 
	\"Recipes clipped from newspapers pasted on both sides of rear free end-paper.\"
  ],
  \"call_no\" : \"TX715 .P962 1858\",
  \"holdings_id\" : \"c2786750\"
  }"
]
```
