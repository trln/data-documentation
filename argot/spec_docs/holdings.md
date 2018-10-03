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
  * Used in UNC serials records to display a "Latest Received" link pointing to checkin details in ILS catalog
* **summary** - Summary holdings statement -- representation of what items are included at the location specified
  * Array, where each separate holdings summary (main bib unit, supplement, index) is an element
  * Required if applicable
  * Preference: do not send a *summary* key with empty array as value if there are no summaries for a holdings record.
* **latest_received_text** - Textual statement about latest issue(s) received. 
  * String
  * Optional per institution

## Basic structure of *holdings* field in Argot

Examples are shown here with line breaks and indentation to make it easier to visually parse them. In real Argot, each *holdings* element is just a string that looks like: 
``` JSON
holdings = ["{\"loc_b\" : \"DHHILL\", \"loc_n\" : \"STACKS\", \"summary\" : \"Issues from 2015-2016\", \"call_no\" : \"ABC 123\", \"latest_received_text\" : \"V.361 NO.6407 SEP 14, 2018.\"}","{\"loc_b\" : \"DHHILL\", \"loc_n\" : \"OTHERPLACE\", \"summary\" : \"Current issues\", \"call_no\" : \"ABC 123\"}"]
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
	\"call_no\" : \"ABC 123\",
	\"latest_received_text\" : \"V.361 NO.6407 SEP 14, 2018.\"
   }",
  "{
    \"loc_b\" : \"DHHILL\", 
	\"loc_n\" : \"OTHERPLACE\", 
	\"summary\" : \"Current issues\", 
	\"call_no\" : \"ABC 123\"
   }"
]
```
