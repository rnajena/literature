#!/bin/bash

#remove encoding
sed -E '/^% Encoding:/ d' $@.bib > tmp.bib
mv tmp.bib $@.bib
#remove unnecessary bibtex fields
sed -E '/^  (owner|pii|revised|country|issn|citation-subset|completed|issn-linking|nlm-id|pubmodel|pubstatus|pmc|month|__markedentry|chemicals|language|mid|references|organization)/ d' $@.bib > tmp.bib
mv tmp.bib $@.bib
#remove comment
sed -E '/^@Comment/ d' $@.bib > tmp.bib
mv tmp.bib $@.bib