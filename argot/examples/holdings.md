# Examples of holdings mappings
## UNC
- Basic structure of holdings json from [Adam's documentation on Confluence](https://trlnmain.atlassian.net/wiki/spaces/TD/pages/6422529/Mapping+Holdings+in+Argot)
- Fields defined at: https://github.com/trln/data-documentation/blob/master/argot/_fields.csv 
- Mapping/logic of UNC data to Argot fields defined at: https://github.com/trln/data-documentation/blob/master/argot/_mappings.csv

Basic procedure: 
- get holdings_record_id value ($a), holdings_location_shelf value ($b) and $c value from each 999 92
  - See [Location issues/considerations: One idea for data mapping/transformation](https://github.com/trln/data-documentation/blob/master/argot/questions_issues/location.md#one-idea-for-data-mappingtransformation) for how *holdings_location_shelf* is turned into *holdings_location_library* value
- to assign holdings_call_number and holdings_note values, for each holdings_record_id value, look for a 999 93 field where $0=#{holdings_record_id value} and $2='852'
- to assign holdings_summary values, for each holdings_record_id value, look for a 999 93 field where $0=#{holdings_record_id value} and $2='866'
- if $c value (from 999 92) > 0, assign holdings_record_id value to holdings_record_id field --- Else, that field is blank

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
holdings_a = [
  {
  "holdings_location_library" : "UNC:Science Library Annex", 
  "holdings_location_shelf" : "bbdaa", 
  "holdings_summary" : "v.1(1988)-v.25(2012)", 
  "holdings_note" : ["Shelved on Index Table"], 
  "holdings_call_number" : "ML113 .I6 B IX"
  },
  {
  "holdings_location_library" : "UNC:Davis Library", 
  "holdings_location_shelf" : "dgdba", 
  "holdings_summary" : "v.26(2013/2014)", 
  "holdings_note" : ["Bound in brown rib grain (T) cloth binding stamped in blind.", "Recipes clipped from newspapers pasted on both sides of rear free end-paper."],
  "holdings_call_number" : "TX715 .P962 1858",
  "holdings_record_id" : "c2786750"
  }
]
```
