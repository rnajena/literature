#!/bin/bash
# script based on cleanbibfile.sh, but actually automated for all .bib files in our directory...
#
# by KL
set -e

if [ $# -eq 0 ]; then
  echo 'No argument given. I will try to clean all .bib files in your current working dir: ' >&2
  echo "$PWD" >&2
  BIBFILES="$(ls $PWD/*bib)"
elif [ -d $1 ]; then
  echo 'Your argument is a directory. I will clean all .bib files I can find.' >&2
  BIBFILES="$(ls $1/*bib)"
elif [ -f $1 ] && [ $# -eq 1 ]; then
  echo 'Only one file found as argument. I will clean this one for you' >&2
  BIBFILES=$1
else
  echo "Found more than one argument. I assume all of those are .bib files." >&2
  BIBFILES="$*"
fi

# echo "$BIBFILES"
for FILE in $BIBFILES; do 
  BN=${FILE%.*}
  
  if [ ! -f "$BN".bib ]; then
    echo "Cannot find $BN.bib. I will continue with the next file." >&2
    continue
  fi

  echo "Cleaning $BN.bib" >&2

  #remove encoding
  sed -E '/^% Encoding:/ d' "$BN".bib > tmp.bib
  mv tmp.bib "$BN".bib
  #remove unnecessary bibtex fields
  sed -E '/^  (owner|pii|revised|country|issn|citation-subset|completed|issn-linking|nlm-id|pubmodel|pubstatus|pmc|month|__markedentry|chemicals|language|mid|references|organization)/ d' "$BN".bib > tmp.bib
  mv tmp.bib "$BN".bib
  #remove comment
  sed -E '/^@Comment/ d' "$BN".bib > tmp.bib
  mv tmp.bib "$BN".bib
done