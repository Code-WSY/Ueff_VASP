############################################vasp_Ueff-1.0.wsy##############################
#!/bin/sh
source ~/.bashrc
#Initialization settings
MAX=0.20
MIN=-0.20
STEP=0.05
cp POSCAR POSCAR.0
#filename##
filename_dft="1-DFT"
filename_NCSF_SCF="2-NCSF+SCF"
filename_NCSF_SCF_1="1-U-NSCF"
filename_NCSF_SCF_2="2-U-SCF"



finish="
                    ###################Author:SuYun Wang###################
                    #####################VASP_Ueff_1.0#####################
                    ###                                                 ###
                    ###                  Finished ! !                   ###
                    ###                                                 ###
                    ###                                                 ###
                    #######################################################
                    #######################################################
"
################################################################################################
###########################################Main#################################################
################################################################################################
################################################################################################
echo "
            ##########################Author:SuYun Wang#############################
            #############################VASP_Ueff_1.0##############################
            ###                                                                  ###
            ###   Please enter the calculation you want to perform:              ###
            ###   0.Generate input file                                          ###
            ###   1.Calculate DFT groudstate                                     ###    
            ###   2.Calculate SCF and NSCF for DFT+U(1 must be completed first)  ###
            ###   3.Extract Ueff data(2 must be completed first)                 ###
            ###                                                                  ###                        
            ########################################################################
            ########################################################################
"
read arg
#################
if (( ${arg}==0 ));then
    echo "
            ##########################Author:SuYun Wang#############################
            #############################VASP_Ueff_1.0##############################
            ###                                                                  ###
            ###   Please enter the input file you want to generate:              ###
            ###   0.VASP run command                                             ###
            ###   1.INCAR(Incomplete)                                            ###
            ###   2.KPOINTS                                                      ###    
            ###   3.POTCAR(Vaspkit needs to be installed)                        ###
            ###                                                                  ###
            ###                                                                  ###                        
            ########################################################################
            ########################################################################
"
read input
####################VASP run command##########################
if (( ${input}==0 )); then
    echo "
            ##########################Author:SuYun Wang#############################
            #############################VASP_Ueff_1.0##############################
            ###                                                                  ###
            ###        Please enter the control command to run VASP              ###
            ###                                                                  ###                        
            ########################################################################
            ########################################################################
"
    read input2
###sub  name####run
runcode='#!/bin/sh
source ~/.bashrc'
##################################
echo "$runcode" > run.wsy
    echo $input2 >>run.wsy

    fi
####################INCAR INPUT###################
    if (( ${input}==1 )); then
       cat>INCAR<<!
SYSTEM=CAL-Ueff
PREC=A
EDIFF=1E-6
ISMEAR=0
SIGMA=0.2
ISPIN=2
MAGMOM=
LORBIT=11
LMAXMIX=4
!
echo -e "$finish"
    
    fi
####################KPOINTS INPUT###################
    if ((${input}==2))  ; then
       cat>KPOINTS<<!
Gamma only
0
Monkhorst
1 1 1
0 0 0
!
echo -e "$finish"
    
    fi
####################POTCAR INPUT###################
    
    if ((${input}==3))  ; then
       cat>INPUT<<!
103
!
vaspkit < INPUT
rm INPUT
echo -e "$finish"
    
    fi


fi
    
####################
if (( ${arg}==1 ));then
    echo "
                ###################Author:SuYun Wang###################
                #####################VASP_Ueff_1.0#####################
                ###                                                 ###
                ###  Please enter the sequence number of the atom   ###
                ###  you want to calculate the U value in POSCAR:   ###
                ###                                                 ###
                #######################################################
                #######################################################
    "
    read arg2
    rm input.wsy
    echo $arg2>>input.wsy
    echo "
                ###################Author:SuYun Wang###################
                #####################VASP_Ueff_1.0#####################
                ###                                                 ###
                ###  Please enter the sequence number of the atom   ###
                ###  you want to calculate the U value in POSCAR:   ###
                ###  1-p;2-d...                                     ###
                ###                                                 ###
                #######################################################
                #######################################################
    "
    read arg3
    echo $arg3>>input.wsy
    #############################################################################
    ##########################CHANGE POSCAR######################################
    ###
    Num_ELE=$(awk -F ' ' '{print NF}' POSCAR|head -7|tail -1|awk '{printf "%d",$1}')
        num=0
        ############################################
        #3
        for ((i=1;i<=${Num_ELE};i++))
            do
            echo $i
            # atoms type number
            E=$(echo $(head -7 POSCAR|tail -1|awk '{print $(i)}' i="$i"))
            #echo $E
            #num:qian n zhong li zi shu zonghe
            #E:di n zhong li zi shu ge shu
            ((num+=E))
            #echo $num
###########################111111######################################
#######################################################################
            if (( $num==$arg2  ))&&(( $E>1 ));then
                value=$i
                echo "condition 1  [3--2 1]"
                atoms_num=$(echo $(head -7 POSCAR|awk '{print $(i)}' i="$i"))
                name=`echo $( head -6 POSCAR|tail -1|awk '$(value)=$(value)" " $(value)' value="$value" )`
                number=`echo $(head -7 POSCAR|tail -1|awk '$(value)=$(value)-1 " " "1"' value="$value")`   
        echo "writing POSCAR"
        echo -e "$(sed  "6c${name}" POSCAR)">POSCAR 
        echo -e "$(sed  "7c${number}" POSCAR)">POSCAR
                echo "written POSCAR!"
                break
            fi
#########################2222222########################################
########################################################################
########################222222222######################################
#######################################################################
            
            if (( $num==$arg2  ))&&(( $E==1 ));then
                echo "condition 2  [1--1]"
                value=$i
                atoms_num=$(echo $(head -7 POSCAR|awk '{print $(i)}' i="$i"))
                #BUbian
                name=`echo $( head -6 POSCAR|tail -1|awk '$(value)=$(value)"' value="$value" )`
                number=`echo $(head -7 POSCAR|tail -1|awk '$(value)=$(value)' value="$value")`

        echo -e "$(sed  "6c${name}" POSCAR)">POSCAR 
        echo -e "$(sed  "7c${number}" POSCAR)">POSCAR
        echo "Written POSCAR!"
                break
            fi
#########################################################################
############################33333333#####################################
if (( $num>$arg2 ))&&(( $E>=3 ))&&(( $((arg2+E-num))!=1 ));then
                echo "condition 3  [3--1 1 1]"
                value=$i
                atoms_num=$(echo $(head -7 POSCAR|awk '{print $(i)}' i="$i" ))
                name=$( echo $( head -6 POSCAR|tail -1|awk '$(value)=$(value)" "$(value)" "$(value)' value="$value" ))
                number=$( echo $( head -7 POSCAR|tail -1|awk '$(value)=E-1-num+arg2" " "1" " " num-arg2' value="$value" E="$E" arg2="$arg2" num="$num" ))
        echo -e "$(sed  "6c${name}" POSCAR)">POSCAR 
        echo -e "$(sed  "7c${number}" POSCAR)">POSCAR
        echo "Written POSCAR!"
                break
            fi
#########################################################################
############################444444444###################################
if (( $num>$arg2 ))&&(( $E>=3 ))&&(( $((arg2+E-num))==1 ));then
                echo "condition 3  [3--1 2]"
                value=$i
                atoms_num=$(echo $(head -7 POSCAR|awk '{print $(i)}' i="$i" ))
                name=$( echo $( head -6 POSCAR|tail -1|awk '$(value)=$(value)" "$(value)' value="$value" ))
                number=$( echo $( head -7 POSCAR|tail -1|awk '$(value)="1" " " E-1' value="$value" E="$E" arg2="$arg2" num="$num" ))
        echo -e "$(sed  "6c${name}" POSCAR)">POSCAR
        echo -e "$(sed  "7c${number}" POSCAR)">POSCAR
        echo "Written POSCAR!"
                break
            fi
#######################################################################
############################5555555####################################
#######################################################################    
            if (( $num>$arg2  ))&&(( $E==2  ));then
                echo "condition 5  [2--1 1]"
                value=$i
                atoms_num=$(echo $(head -7 POSCAR|awk '{print $(i)}' i="$i" ))
                name=$( echo $( head -6 POSCAR|tail -1|awk '$(value)=$(value)" "$(value) ' value="$value" ))
                number=$( echo $( head -7 POSCAR|tail -1|awk '$(value)="1" " " "1" ' value="$value" ))
        echo -e "$(sed  "6c${name}" POSCAR)">POSCAR
        echo -e "$(sed  "7c${number}" POSCAR)">POSCAR
        echo "Written POSCAR!"
                break
            fi
    done

##################generat POTCAR for DFT############################  
rm POTCAR
cat>INPUT<<!
103
!
vaspkit < INPUT
rm INPUT
################################DFT STATE##############################
mkdir ${filename_dft}
cd ${filename_dft}
cp ../INCAR ../POSCAR ../POTCAR ../KPOINTS ./
##run##
bash ../run.wsy
cd ..
#########################################################################
    #calculation DFT
    #calculate U_{eff}
mkdir "2-NCSF+SCF"
cd "2-NCSF+SCF"
    for i in $(seq ${MIN} ${STEP} ${MAX})
        do
        mkdir -- "$i"
        cd -- $i
        mkdir ${filename_NCSF_SCF_1} ${filename_NCSF_SCF_2}
        ### 2-/
        cp ../../INCAR ../../POSCAR ../../POTCAR ../../KPOINTS ${filename_NCSF_SCF_1}
        cp ../../INCAR ../../POSCAR ../../POTCAR  ../../KPOINTS ${filename_NCSF_SCF_2}        
        ####
        cd ${filename_NCSF_SCF_1}
        echo "ICHARG=11">>INCAR 
        cd ../${filename_NCSF_SCF_2}
        echo "ICHARG=1">>INCAR
        cd ../../

    done
echo -e "$finish"
fi
########################################
########################################
if (( ${arg}==2 ));then
        arg2=$(echo $(head -1 input.wsy|awk '{print $1}'))
        arg3=$( echo $(head -2 input.wsy|tail -1|awk '{print $1}'))   
 ######################################################################       
 cd ${filename_NCSF_SCF} 
    #1
    for file in $(seq ${MIN} ${STEP} ${MAX})
        do          
        cd -- ${file}
        #2   
        for items in 1 2
            do
            if (( $items==1 ));then
            cd ${filename_NCSF_SCF_1}
            #copy CHGCAR AND WAVECAR TO 2 3
            cp ../../../${filename_dft}/CHGCAR ./
            cp ../../../${filename_dft}/WAVECAR ./  
            else
            cd ${filename_NCSF_SCF_2}
            #copy CHGCAR AND WAVECAR TO 2 3
            cp ../../../${filename_dft}/CHGCAR ./
            cp ../../../${filename_dft}/WAVECAR ./           
            fi
        #Calculate the number of element types
    
        Num_ELE=$(awk -F ' ' '{print NF}' POSCAR|head -7|tail -1|awk '{printf "%d",$1}')
        num=0
        ############################################
        #3
        for ((i=1;i<=${Num_ELE};i++))
            do
            #echo $i
            # atoms type number
            E=$(echo $(head -7 POSCAR|tail -1|awk '{print $(i)}' i="$i"))
            #echo $E
            #num:qian n zhong li zi shu zonghe
            #E:di n zhong li zi shu ge shu
            ((num+=E))
            #echo $num
###########################write INCAR######################################
############################################################################
            if (( $num==$arg2  ));then                
                #input INCAR
                LDAUL=""
                LDAUU=""
                LDAUJ=""
                A=-1
                B=0
                echo "writing..."

                #echo ${Num_ELE}
                for ((j=1;j<=${Num_ELE};j++))
                    do 
                    if (($j==$i));then
                        LDAUL="$LDAUL $arg3 "
                        LDAUU="$LDAUU ${file} "
                        LDAUJ="$LDAUJ ${file} "
                    fi
                    if (($j!=${Num_ELE}));then
                        #statements
                        LDAUL="$LDAUL $A"
                        LDAUU="$LDAUU $B"
                        LDAUJ="$LDAUJ $B"
                    fi   
                    done
                    
echo "writing INCAR...."                
echo "###########LSDAU###########
LDAU=.TRUE.
LDAUTYPE = 3
LDAUL = $LDAUL
LDAUU = $LDAUU
LDAUJ = $LDAUJ
">>INCAR
echo "written INCAR!"

##########################run##########################
bash ../../../run.wsy

            break
            fi
#######################################################################
#######################################################################            
            if  (( $num<$arg2  ));then  

                 continue
            fi

        done
        #3        
    cd ..
    # 2-3
    done 
    cd ..
done   
cd ..
        
echo -e "$finish"
    
fi

###########################################################################
if (( ${arg}==3 ));then
    item=0
    atoms_num=$(echo $(head -1 input.wsy|awk '{print $1}'))
    orbit=$( echo $(head -2 input.wsy|tail -1|awk '{print $1}'))
#######################CHG-DFT################################################
    cd -- ${filename_dft}
    chgDFT=`grep -$((atoms_num+3)) "total charge" OUTCAR|tail -1|awk '{print $((E+2))}' E="$orbit" `
    cd ..
#echo "sorry,unfinished!"
echo "U     ""   DFT   " "   NSCF   " " SCF    "    >output.wsy
for i in $(seq ${MIN} ${STEP} ${MAX})
        do
        item=$((item+=1)) 
        cd ${filename_NCSF_SCF}    
        cd -- $i
        #######################CHG-NSCF################################################
        cd -- ${filename_NCSF_SCF_1}
        chgNSCF=`grep -$((atoms_num+3)) "total charge" OUTCAR|tail -1|awk '{print $((E+2))}' E="$orbit" `
        #######################CHG-SCF#################################################
        cd -- ../${filename_NCSF_SCF_2}
        chgSCF=`grep -$((atoms_num+3)) "total charge" OUTCAR|tail -1|awk '{print $((E+2))}' E="$orbit" `

        if [ $(bc <<< "$i == $MIN") -eq 1 ] ;then
            CHGDIFF_NSCF1=$chgNSCF
            CHGDIFF_SCF1=$chgSCF
            #echo $chgSCF
        fi

        if [ $(bc <<< "$i == $MAX") -eq 1 ] ;then
            CHGDIFF_NSCF2=$chgNSCF
            CHGDIFF_SCF2=$chgSCF
            DELTA_V=$(echo "scale=3;$item*$STEP-$STEP"|bc )
            #echo $DELTA_V
            XSCF=`awk -v m1=$CHGDIFF_SCF1 -v m2=$CHGDIFF_SCF2 -v DELTA_V=$DELTA_V 'BEGIN{print m2/DELTA_V-m1/DELTA_V}'`
            XNSCF=`awk -v m1=$CHGDIFF_NSCF1 -v m2=$CHGDIFF_NSCF2 -v DELTA_V=$DELTA_V 'BEGIN{print m2/DELTA_V-m1/DELTA_V}'`
            Ueff=`awk -v m1=$XSCF -v m2=$XNSCF 'BEGIN{print 1/m1-1/m2}'`
            #echo $Ueff
        fi
        cd ..
        #0.*
        cd ..
        #2-d
        cd ..
        #~
        echo "$i" " " "$chgDFT " "  $chgNSCF" " " " $chgSCF "   >>output.wsy
done
        echo "Ueff:   " "$Ueff" >>output.wsy

echo -e "$finish"
cat output.wsy
fi
