# Instructions


Modify Alpha1.50 to specify up to 2 output file formats (i.e. eps & png) 
--------------------

    mkdir -p eps pdf png

    tecplot -b -p Alpha1.50.mcr

Note that you can enable or disable the "Preliminary" Label in SectionalCuts.mcr


Convert eps to pdf
--------------------

    for i in $(ls -1d eps/*.eps); do
       rm -f pdf/$(basename ${i%.*}.pdf)
       epstopdf eps/$(basename ${file%.*}.eps) -o=pdf/$(basename ${i%.*}.pdf)
       pdfcrop  pdf/$(basename ${i%.*}.pdf)       pdf/$(basename ${i%.*}.pdf)
    done
