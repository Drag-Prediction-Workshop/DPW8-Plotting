# Instructions


Modify Grids.mcr and Alphas.mcr to specify up to 2 output file formats (i.e. eps & png) 
--------------------

    tecplot -b -p Grids.mcr
    tecplot -b -p Alphas.mcr


Note that you can enable or disable the "Preliminary" Label in Grids.mcr/Alphas.mcr

Note that you can enable or disable the TestCase1b Unsteady Buffet Results in Grids.mcr/Alphas.mcr


Convert eps to pdf
--------------------
#!/bin/bash

    for i in $(ls -1d eps/*.eps); do
       /bin/rm -f pdf/$(basename ${i%.*}.pdf)
       /boeing/bin/ossrun ver=2019.1 epstopdf $i -o=pdf/$(basename ${i%.*}.pdf)
       /boeing/bin/ossrun ver=2019.1 pdfcrop        pdf/$(basename ${i%.*}.pdf) pdf/$(basename ${i%.*}.pdf)
    done

