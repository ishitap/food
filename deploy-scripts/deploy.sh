#!/bin/sh
BASEDIR=../
cp $BASEDIR/indexheader.html index.html
for f in $BASEDIR/*.md; do
    pandoc -i $f -o tmp.html
    echo -n "<li><a href=\"$(basename $f | cut -d . -f 1).html\">" >> index.html
    cat tmp.html | pup 'h1 text{}' | head -n 1 | tr -d '\n' >> index.html
    echo "</a></li>" >> index.html
    cp $BASEDIR/deploy-scripts/styleheader.html .
    echo "<title>$(cat tmp.html | pup 'h1 text{}' | head -n 1 | tr -d '\n')</title>" >> styleheader.html
    cat styleheader.html tmp.html > $BASEDIR/html/$(echo $(basename $f) | cut -d . -f 1 -s).html
    rm styleheader.html tmp.html
done
cp -R $BASEDIR/assets/* $BASEDIR/html/
cat index.html $BASEDIR/indexfooter.html > $BASEDIR/html/index.html
rm index.html
