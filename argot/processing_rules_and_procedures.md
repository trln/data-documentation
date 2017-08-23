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
