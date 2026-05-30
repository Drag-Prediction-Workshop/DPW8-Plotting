# Instructions

Modify TestCase2b.mcr to specify up to 2 output file formats (i.e. eps & png) 
--------------------

    tecplot -b -p TestCase2b.mcr


Note that you can enable or disable the "Preliminary" Label in TestCase2b.mcr


Convert eps to pdf
--------------------
#!/bin/bash

    for i in $(ls -1d eps/*.eps); do
       rm -f pdf/$(basename ${i%.*}.pdf)
       epstopdf eps/$(basename ${file%.*}.eps) -o=pdf/$(basename ${i%.*}.pdf)
       pdfcrop  pdf/$(basename ${i%.*}.pdf)       pdf/$(basename ${i%.*}.pdf)
    done
