
!/bin/sh
for i in   4 6 8 12
do
  	mkdir -p site_$i
        cd site_$i
for j in  1.0 2.0 4.0 6.0 8.0 10.0 12.0 14.0 16.0
do
  	mkdir -p u_$j


        cd ../

        cp 2d_1brgf.f90 site_$i/u_$j
        cp mtfort90.f site_$i/u_$j
        cd site_$i/u_$j

        echo "7789"                !seed               >> input.dat
        echo "$i"                  !system size        >> input.dat
        echo "-1.0"                !t                  >> input.dat
        echo "$j"                  !U                  >> input.dat
        echo "0.50"                !filling            >> input.dat
        echo "-4.0"                !wmin               >> input.dat
        echo "4.0"                 !wmax               >> input.dat
        echo "100"                 !nwp                >> input.dat
        echo "500"                !nms                >> input.dat

        gfortran  mtfort90.f 2d_1brgf.f90  -lblas -llapack -L/usr/lib/libblas.so.4

        echo "#PBS -N   U_"$j                           >> job_long.sge
        echo "#PBS -l nodes=1:ppn=1"                   >> job_long.sge
        echo "#PBS -j oe "                              >> job_long.sge
        echo "#PBS -o out.log"                          >> job_long.sge
        echo "#PBS -e err.log"                          >> job_long.sge
        echo "cd" \$PBS_O_WORKDIR                       >> job_long.sge
        echo "date"                                     >> job_long.sge
        echo "time ./a.out > main.out    "              >> job_long.sge
        chmod 777 job_long.sge
        qsub job_long.sge

        cd ..
done
    	cd ..
done

