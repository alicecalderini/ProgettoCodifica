# ProgettoCodifica
Progetto codifica di testi. aa 2023/2024 realizzato da Alice Calderini e Lorenzo Novelli

# Validazione XML
per la validazione è stato utilizzato Xerces-J-bin.2.12.1.
```
java -cp "Xerces-J-bin.2.12.1\xerces-2_12_1\*" dom.Counter -v progetto.xml
```
L'output è
```
progetto.xml: 368;57;1 ms (3151 elems, 11958 attrs, 23923 spaces, 53916 chars)
```

# Trasformazione attraverso XSLT
per la creazione dell'HTML è stato utilizzato SaxonHE12-5J 
```
java -jar "./SaxonHE12-5J/saxon-he-12.5.jar" -s:progetto.xml -xsl:trasformazione.xsl -o:progetto.html
```

