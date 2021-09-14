#!/bin/bash


if [ -n "$1" ]
then

    while IFS= read -r line; do
      STR2=$line

echo $STR2

  #    STR2="${STR:2}"
      STR3=`echo $STR2 | sed s/.jpg.*//g`
      STR4=$STR3"_thumbnail.jpg"



      if grep -q "thumbnail" <<< "$STR2"; then

      echo 0

      elif [ -f $STR4 ]; then
        echo Пропускаем $STR2
      else


         razr_x=`identify 1.jpg | awk '{print $(NF-6)}'|cut -dx -f 1`
         razr_y=`identify $STR2 | awk '{print $(NF-6)}'|sed 's/.*x//'`
          #echo "$razr_x $razr_y"

         if (($razr_x>360)) && (($razr_x >= $razr_y)); then
         convert ${STR2} -resize 360 ${STR3}_thumbnail.jpg
         echo "Конвертируем $STR2"

          else

           if (($razr_y>360)) && (($razr_x < $razr_y)); then

      #     STR3=`echo $STR2 | sed s/.jpg.*//g`
            convert ${STR2} -resize x360 ${STR3}_thumbnail.jpg
           echo "Конвертируем $STR2"

         fi
         fi
         fi







    done <<< $(cat $1)


echo "Переданны параметры, $1"





else


 echo "Параметры не переданны"

for STR in `find . -name "*.jpg"`
   do

STR2="${STR:2}"
STR3=`echo $STR2 | sed s/.jpg.*//g`
STR4=$STR3"_thumbnail.jpg"



if grep -q "thumbnail" <<< "$STR2"; then

echo 0

elif [ -f $STR4 ]; then
  echo Пропускаем $STR2
else


   razr_x=`identify 1.jpg | awk '{print $(NF-6)}'|cut -dx -f 1`
   razr_y=`identify $STR2 | awk '{print $(NF-6)}'|sed 's/.*x//'`
    #echo "$razr_x $razr_y"

   if (($razr_x>360)) && (($razr_x >= $razr_y)); then
   convert ${STR2} -resize 360 ${STR3}_thumbnail.jpg
   echo "Конвертируем $STR2"

    else

     if (($razr_y>360)) && (($razr_x < $razr_y)); then

#     STR3=`echo $STR2 | sed s/.jpg.*//g`
      convert ${STR2} -resize x360 ${STR3}_thumbnail.jpg
     echo "Конвертируем $STR2"

   fi
   fi
   fi
   done


   fi
