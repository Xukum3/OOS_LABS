#!/bin/bash

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}

printblockdevices() {
  lsblk -o FSTYPE,MOUNTPOINT | awk -F'\t| {1,}' '{
	if ($2 != "") {
		system("df --output=source,target | grep $2/$ | cut -d \' \' -f1")
		printf ("\t%s\t%s\n", $1, $2);
  	}
  }'
}

printblockdevices

PS3='Please enter your choice: '
options=("Вывести таблицу файловых систем" "Монтировать файловую систему"\
 "Отмонтировать файловую систему" "Изменить параметры монтирования примонтированной файловой системы" \
 "Вывести параметры монтирования примонтированной файловой системы"\
 "Вывести детальную информацию о файловой системе ext*" \
 "Выйти"
)

select opt in "${options[@]}"
do
    case $opt in
        "Вывести таблицу файловых систем")
            echo "you chose choice 1"
            lsblk --list | awk -F'\t| {1,}' '{
		if ($7 != "")
			printf ("%s\t%s\t%s\n", $1, $6, $7);
	    }'
            ;;

	"Монтировать файловую систему")
            read -p "Введите путь до файла/устройства: " filepath
	    if [ ! -b $filepath ] && [ ! -f $filepath ]; then
		err "not exist or not a blockdevice|file"
		continue
            fi

	    read -p "Введите каталог монтирования: " mountpath

	    if [ ! -e $mountpath ]; then
		err "not exist"
		mkdir $mountpath
	    elif [ -d $mountpath ]; then
		if [ -z "$(ls -A $mountpath)" ]; then
			err "dir exists and empty"
		else
			err "dir exists and not empty"
			continue
		fi
	    else
		err "Not a directory"
		continue
	    fi

	    if [ -f $filepath ]; then
            	device=$(sudo losetup --find --show $filepath)
	    	echo $device
		#mount $device $mountpath
	    else
		echo ok
            	#mount $filepath $mountpath
            fi
	    ;;
	"Отмонтировать файловую систему")
            read -p "Введите путь до файловой системы: " filesyspath #считать с консоли или дать выбрать
            umount $filesyspath
	    ;;

        "Изменить параметры монтирования примонтированной файловой системы")
	    read -p "Введите путь до файловой системы: " remountfilesyspath #считать с консоли или дать выбрать
	    read -p "1: только чтение\n2: чтение и запись\n" decision #сделать нормально
	    #if 1
	    mount -o remount,ro $remountfilesyspath
	    #if 2
            mount -o remount,rw $remountfilesyspath
            ;;
        "Вывести параметры монтирования примонтированной файловой системы")
	    read -p "Введите путь до файловой системы: " filesyspath #считать с консоли или дать выбрать
	    mount | grep $filesyspath
            ;;
 	"Вывести детальную информацию о файловой системе ext*")
	    echo "Имеются следующие файловые системы ext*"
	    df -Th -t ext2 -t ext3 -t ext4 -t extcow | awk -F'\t| {1,}' '{ printf ("%s\t%s\t%s\n", $1, $2, $7) }'
	    read -p "Введите путь до файловой системы ext4: " ext4syspath #считать с консоли или дать выбрать
	    tune2fs -l $ext4syspath
            ;;
        "Выйти")
            break
            ;;
	*) echo "invalid option $REPLY";;
    esac
done

