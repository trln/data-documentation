- [Argot *items* field](#argot--items--field)
  * [Subelements](#subelements)
  * [Basic structure of *items* field in Argot](#basic-structure-of--items--field-in-argot)
  * [Institution-specific item mapping examples](#institution-specific-item-mapping-examples)
    + [UNC mapping examples](#unc-mapping-examples)
      - [call_no (UNC)](#call-no--unc-)



# Argot *items* field

The Argot *items* field is an array of item elements. Each item element is an an escaped JSON string representing an item record attached to the bib.

* **Required?**
  * This field is required for physical items. 
  * It is not required for online resources.
* **Repeatable/multivalued?**
  * The *items* field itself is not repeated in the Argot record representing a bib record
  * The *items* field may contain multiple elements representing multiple item records attached to the bib
  * The order of item elements in the *items* field should represent the display order of items desired

## Subelements
* **call_no**
  * full call number, including any volume and/or copy designators
  * required
* **cn_scheme**
  * code representing call number or classification number scheme
    * **ALPHANUM** - local or other classification schemes sorted alphanumerically
    * **DDC** - Dewey Decimal Classification
    * **LC** - Library of Congress Classification
    * **NAL** - National Agrigulture Library Classification
    * **NLM** - National Library of Medicine Classification
    * **SUDOC** - Superintendent of Documents Classification System
  * required
* **due_date**
  * Optional
  * Only populate if status = Checked out
  * ISO 8601 date or timestamp. Any of the following will work.
    * 2017-10-25
	* 2017-10-25T12:43
	* 2017-10-25T12:43:57
	* 2017-10-25T15:40:35+00:00
	* Note: Any format that can be handled by the [Ruby Time.parse](https://ruby-doc.org/stdlib-2.4.0/libdoc/time/rdoc/Time.html) method should work.
* **loc_b** - Broad location - Library building, major area/division
  * ILS code
  * Required
* **loc_n** - Narrow location
  * ILS code
  * Required
* **notes** - Item notes for public display
  * Array, where each separate note from item record is an element
  * Required if display of public notes is desired
  * If there are no notes to publicly display, prefer to **not** send *notes* subelement with empty array
* **rec_id**
  * Local id of item record
  * Optional per institution - format consistently to meet institutional needs
* **status**
  * Human readable, local status message for the item
  * Required
* **type**
  * Item type
  * Optional per institution - format consistently to meet institutional needs



## Basic structure of *items* field in Argot

Examples are shown here with line breaks and indentation to make it easier to visually parse them. In real Argot, each *items* element is just a string that looks like: 
``` JSON
items = ["{\"loc_b\" : \"DHHILL\",\"loc_n\" : \"STACKS\",\"call_no\" : \"ABC 123 2015\",\"cn_scheme\" : \"LC\",\"status\" : \"Available\",\"notes\" : [\"First item note\",\"Second item note\"],\"type\" : \"BOOK\"}"]
```

``` JSON
items = [
  "{
  \"loc_b\" : \"DHHILL\",
  \"loc_n\" : \"STACKS\",
  \"call_no\" : \"ABC 123 2015\",
  \"cn_scheme\" : \"LC\",
  \"status\" : \"Available\",
  \"notes\" : [
    \"First item note\",
	\"Second item note\"
	],
  \"type\" : \"BOOK\"
  }",
  "{
  \"loc_b\" : \"DHHILL\",
  \"loc_n\" : \"STACKS\",
  \"call_no\" : \"ABC 123 2016\",
  \"cn_scheme\" : \"LC\",
  \"status\" : \"Checked out\",
  \"type\" : \"BOOK\"
  }"
]
```

## Institution-specific item mapping examples
Institutions are encouraged, but not required to document their item mappings here.

### UNC mapping examples
#### call_no (UNC)

Where field tag = 999 AND ind1 = 9 and ind2 = 1:
- Process subfield q
  - Strip initial subfield delimiter (=~ /^\|./)
  - Replace subsequent subfield delimiters with space
- If subfield v is present
  - add space to call_no, followed by content of $v
- If subfield c is present and != 1
  - add " c." to call_no, followed by content of $c


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
        <subfield code='n'>Public note here</subfield>
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
        <subfield code='s'>-</subfield>
        <subfield code='d'>2017-10-31</subfield>
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
  \"loc_b\" : \"dhca\",
  \"loc_n\" : \"dhca\",
  \"call_no\" : \"PR1367 .M34 v.9(1959/1960)\",
  \"cn_scheme\" : \"LC\",
  \"status\" : \"In-Library Use Only\",
  \"rec_id\" : \"i1763213\",
  \"notes\" : ["Public note here"]
  }",
  "{
  \"loc_b\" : \"dhca\",
  \"loc_n\" : \"dhca\",
  \"call_no\" : \"PR1367 .M34 v.9(1959/1960) c.2\",
  \"cn_scheme\" : \"LC\",
  \"status\" : \"In-Library Use Only\",
  \"rec_id\" : \"i9509452\",
  }",
  "{
  \"loc_b\" : \"dhca\",
  \"loc_n\" : \"dhca\",
  \"call_no\" : \"PR1367 .M34 v.33(1983/1984)\",
  \"cn_scheme\" : \"LC\",
  \"status\" : \"Checked Out\",
  \"due_date\" : \"2017-10-31\",
  \"rec_id\" : \"i9509453\",
  }"
]
```
