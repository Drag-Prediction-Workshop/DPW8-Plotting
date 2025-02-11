# Instructions


Modify Grids.mcr and Alphas.mcr to specify up to 2 output file formats (i.e. eps & png) 
--------------------

    tecplot -b -p Grids.mcr
    tecplot -b -p Alphas.mcr


Convert eps to pdf
--------------------

    for i in $(ls -1d eps/*.eps); do
       rm -f pdf/$(basename ${i%.*}.pdf)
       epstopdf $i -o=pdf/$(basename ${i%.*}.pdf)
       pdfcrop pdf/$(basename ${i%.*}.pdf) pdf/$(basename ${i%.*}.pdf)
    done
