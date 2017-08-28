# Processing rules/procedures
## IN GENERAL
*Unless otherwise specified:*
 - trim leading and trailing spaces
 - collapse multiple spaces to one space

## processing_type = concat_subelements
 - /unless otherwise specified/, add a space at the end of each subelement

## All fields that become facet values
1. strip trailing punctuation (but leave hyphens that are at the end)

If we can do this in a smart way, great. If not, it's better to occasionally get stuff like:

```
Speeches, addresses, etc
```

...than to always much more frequently be getting separate facet values for things like:

```
Smith, Bob
Smith, Bob.
Smith, Bob, 
```

## $e and $4 (and in X11 headings, $j)
Do the following steps per heading. 

Source for mapping to terms for $4: MARC relators list either from [live id.loc.gov lookup](http://id.loc.gov/vocabulary/relators); [download of id.loc.gov dataset](http://id.loc.gov/download/); or some kind of scrape from [MARC code list for relators](https://www.loc.gov/marc/relators/relaterm.html). 

- strip period from end of $e/$j value(s)
- expand $4 code to English term
- deduplicate relator values for the heading
- flatten relator values to a string, separated by ", "

### Example
```
700 1 _ $aBalme, D. M.$q(David M.),$d1912-1989,$etranslator.$4trl
```

Becomes: 

```
contributor : ["Balme, D. M. (David M.), 1912-1989,"]
contributor_relator : ["translator"]
```

Displayed as: 

> Contributor(s): ++Balme, D. M. (David M.), 1912-1989,++ translator

If we do what is currently done in Endeca, then the underlined portion above is hyperlinked and does a quoted/phrase search of the author index for entire name. 

### Example
```
700 1 _ $aBenjamin, Arthur,$d1893-1960,$earranger of music.$4prf
700 1 _ $aStämpfli, Jakob,$d1934-$esinger.$4prf
```

Becomes: 
```
contributor : ["Benjamin, Arthur, 1893-1960,", "Stämpfli, Jakob, 1934-"]
contributor_relator : ["arranger of music, performer", "singer, performer"]
```
