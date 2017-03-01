# Argot Attributes
- key: "human-readable" key. Gets concatenated to parent key
- multi: multi-valued field?
- indexed: indexed?
- stored: stored? (for display)
- sort: used for sorting?
- ee: Endeca Property
- description: Additional information
- type: the dynamic field definition this field maps to https://github.com/trln/solr6_test_conf/blob/master/configure/stock.yaml
    
In addition, there are, currently, 3 unique types
    
 ## Hash (hash)
 
 indicates the field has children
    
 ## General Vernacular Object (gvo)
 
 a short-hand for an additional nesting pattern
 
 e.g.
```
 - key: main
   type: gvo
   multi: false
   indexed: true
   stored: true
   sort: false
   ee: Main Title
   description: ~
```

becomes
```
- key: main
type: hash
ee: Main Title
description: ~
children:
- key: value
 multi: false
 indexed: true
 stored: true
 sort: false
 type: t
- key: vernacular
 type: hash
 children:
 - key: lang_code
   type: str
   multi: false
   indexed: false
   stored: false
   sort: false
 - key: value
   type: t
   multi: false
   indexed: true
   stored: true
   sort: false
```

# Linking Object (lo)

a short-hand for an additional nesting pattern
    
e.g.
```
- key: subseries
  type: lo
  multi: true
  indexed: true
  stored: true
  sort: false
  ee: ~
  description: ~
```

becomes
```
- key: subseries
  type: hash
  multi: true
  indexed: true
  stored: true
  sort: false
  ee: ~
  description: ~
  children:
  - key: value
    type: t
    multi: true
    indexed: true
    stored: false
    sort: false
  - key: linking_isn
    type: str
    multi: true
    indexed: true
    stored: false
    sort: false
```
