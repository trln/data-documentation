# Argot nested JSON examples for item data

## Basic structure of *items* field in Argot
``` JSON
items = [
  "{
  \"item_location_library\" : \"DHHILL\",
  \"item_location_shelf\" : \"STACKS\",
  \"item_call_number\" : \"ABC 123 2015\",
  \"item_classification_scheme\" : \"LC\",
  \"item_status\" : \"Available\",
  \"item_due_date\" : \"\",
  \"item_record_id\" : \"12348765\",
  \"item_note\" : [
    \"First item note\",
	\"Second item note\"
	]
  }",
  "{
  \"item_location_library\" : \"DHHILL\",
  \"item_location_shelf\" : \"STACKS\",
  \"item_call_number\" : \"ABC 123 2016\",
  \"item_classification_scheme\" : \"LC\",
  \"item_status\" : \"Checked out\",
  \"item_due_date\" : \"2017-12-21\",
  \"item_record_id\" : \"12348792\",
  \"item_note\" : []
  }"
]
```

## UNC mapping examples
### item_call_number

Where field tag = 999 AND ind1 = 9 and ind2 = 1:
- Process subfield q
  - Strip initial subfield delimiter (=~ /^\|./)
  - Replace subsequent subfield delimiters with space
- If subfield v is present
  - add space to item_call_number, followed by content of $v
- If subfield c is present and != 1
  - add " c." to item_call_number, followed by content of $c


**Source data (MARC-XML)**
``` XML
      <datafield ind1='9' ind2='1' tag='999'>
        <subfield code='i'>i1763213</subfield>
        <subfield code='l'>dhca</subfield>
        <subfield code='s'>o</subfield>
        <subfield code='t'>3</subfield>
        <subfield code='c'>1</subfield>
        <subfield code='o'>0</subfield>
        <subfield code='b'>00017336580</subfield>
        <subfield code='p'>090</subfield>
        <subfield code='q'>|aPR1367|b.M34</subfield>
        <subfield code='v'>v.9(1959/1960)</subfield>
      </datafield>
      <datafield ind1='9' ind2='1' tag='999'>
        <subfield code='i'>i9509452</subfield>
        <subfield code='l'>dhca</subfield>
        <subfield code='s'>o</subfield>
        <subfield code='t'>3</subfield>
        <subfield code='c'>2</subfield>
        <subfield code='o'>0</subfield>
        <subfield code='b'>00043654802</subfield>
        <subfield code='p'>090</subfield>
        <subfield code='q'>|aPR1367|b.M34</subfield>
        <subfield code='v'>v.9(1959/1960)</subfield>
      </datafield>
      <datafield ind1='9' ind2='1' tag='999'>
        <subfield code='i'>i9509453</subfield>
        <subfield code='l'>dhca</subfield>
        <subfield code='s'>o</subfield>
        <subfield code='t'>3</subfield>
        <subfield code='c'>1</subfield>
        <subfield code='o'>0</subfield>
        <subfield code='b'>00043654811</subfield>
        <subfield code='p'>090</subfield>
        <subfield code='q'>|aPR1367|b.M34</subfield>
        <subfield code='v'>v.33(1983/1984)</subfield>
      </datafield>
```

**Output data (Argot)**
``` JSON
items = [
  "{
  \"item_location_library\" : \"dh\",
  \"item_location_shelf\" : \"dhca\",
  \"item_call_number\" : \"PR1367 .M34 v.9(1959/1960)\",
  \"item_classification_scheme\" : \"LC\",
  \"item_status\" : \"In-Library Use Only\",
  \"item_due_date\" : \"\",
  \"item_record_id\" : \"i1763213\",
  \"item_note\" : []
  }",
  "{
  \"item_location_library\" : \"dh\",
  \"item_location_shelf\" : \"dhca\",
  \"item_call_number\" : \"PR1367 .M34 v.9(1959/1960) c.2\",
  \"item_classification_scheme\" : \"LC\",
  \"item_status\" : \"In-Library Use Only\",
  \"item_due_date\" : \"\",
  \"item_record_id\" : \"i9509452\",
  \"item_note\" : []
  }",
  "{
  \"item_location_library\" : \"dh\",
  \"item_location_shelf\" : \"dhca\",
  \"item_call_number\" : \"PR1367 .M34 v.33(1983/1984)\",
  \"item_classification_scheme\" : \"LC\",
  \"item_status\" : \"In-Library Use Only\",
  \"item_due_date\" : \"\",
  \"item_record_id\" : \"i9509453\",
  \"item_note\" : []
  }"
]
```
