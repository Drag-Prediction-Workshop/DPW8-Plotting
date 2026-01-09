# Instructions


Modify Grids.mcr and Alphas.mcr to specify up to 2 output file formats (i.e. eps & png) 
--------------------

    tecplot -b -p Grids.mcr
    tecplot -b -p Alphas.mcr


Note that you can enable or disable the "Preliminary" Label in Grids.mcr/Alphas.mcr

Note that you can enable or disable the TestCase1b Unsteady Buffet Results in Grids.mcr/Alphas.mcr


Convert eps to pdf
--------------------

    for i in $(ls -1d eps/*.eps); do
       rm -f pdf/$(basename ${i%.*}.pdf)
       epstopdf $i -o=pdf/$(basename ${i%.*}.pdf)
       pdfcrop pdf/$(basename ${i%.*}.pdf) pdf/$(basename ${i%.*}.pdf)
    done
