#!/bin/csh -f

set files = `ls -tr *png`

convert $files fandm.pdf
mv fandm.pdf ../pdf/.
